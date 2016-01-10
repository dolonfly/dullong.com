title: 小序Cloudcmp的network(网络任务)
date: 2013-05-13 09:14:42
tags:
---

Cloudcmp 具有的三个重要的测试任务分别是：计算、存储和网络。而在本片文章中主要介绍一下其关于网络性能测试的任务。    

对于网络性能，主要是通过tcp吞吐量和延迟来衡量的，因此本部分也是通过测量这两方面的性能来评测不同云平台的网络性能的。

以下分别对带宽和延迟来分别说明

<!-- more -->

## 延迟

对于所有的任务来说，每个实现类均集成了基类Task，并实现重写了一些一些方法，而对于重写的方法来说，run()方法是最核心的一个方法。我们这里并不对他类是怎么写的来说明，仅仅说明其是如何实现的这一对延迟进行测量的方法。

核心代码如下：

        InetSocketAddress sockAddr = new InetSocketAddress(targetAddr, targetPort);
        // try connect
        Socket s = new Socket();
        long startTime = System.nanoTime();
        long duration;
        s.connect(sockAddr);
        duration = (System.nanoTime() - startTime) / 1000; // in microseconds
        s.close();

其中，targetAddr和targetPort分别为地址的ip和端口号，而这一段的主要作用就是建立一个socket连接，并且连接成功所需要的时间，通过这个时间，并可以大概的计算出性能如何。通过多次进行这个方法并且求其平均值，便可以计算出某个云平台的网络延迟如何。

## 带宽

核心代码如下：

    public long measureBandwidth(String targetAddr, long transferSize) throws IOException {
        int targetPort;
        if (!configs.containsKey("bw_port")) {
            return -1;
        }
        
        targetPort = Integer.parseInt(configs.get("bw_port"));        
        
        InetSocketAddress sockAddr = new InetSocketAddress(targetAddr, targetPort);
        
        Socket s = new Socket();
        s.setTcpNoDelay(true);
        s.setSendBufferSize(8000000); // 8MB send buffer, enough for wide-area transfer
        byte [] buffer = new byte[8000000];
        long startTime;
        long duration;
        try {
            s.connect(sockAddr);
            long transferred = 0;
            InputStream is = s.getInputStream();
            OutputStream os = s.getOutputStream();
            
            byte [] transferSizeBytes = ByteBuffer.allocate(8).putLong(transferSize).array();            
            os.write(transferSizeBytes); // first tell the destination how many bytes we are going to send
            os.flush();
            
            startTime = System.nanoTime();
            while (transferred < transferSize) {
                os.write(buffer);
                transferred += buffer.length;
            }
            os.flush();
            is.read(); // waiting for all bytes to be received by the destination
            duration = System.nanoTime() - startTime;
            s.close();
        }
        catch (IOException ex) {
            throw ex;
        }
        catch (Exception ex) {
            ex.printStackTrace();
            return -1;
        }
        
        return (long)(transferSize * 8 / ((double)duration / 1000000000));
    }

 
关于带宽的计算上面，用到了与计算延迟相同的方法，只是对于延迟，不需要传输数据，而带宽则是通过多次进行传输一固定数据 transferSize ，获取操作时间来计算带宽的。关于带宽的计算公式为：带宽=传输大小*8/时间

由上看来，关于Cloudcmp的网络性能方面，其做的并不是太复杂，由此可见，一个大的工程并不是都是复杂的东西堆砌出来的，对于复杂的问题，都是一个一个简单的问题组成的，当简单的问题解决了，复杂的也就自然而然的解决了。