#!/usr/bin/env bash
hexo g
scp -r -i ~/.ssh/dll_home_aliyun.pem ./public/* root@139.224.12.203:/data/www/dullong.com