@echo off
title 关闭常见的危险端口
echo 正在开启Windows防火墙
echo.
netsh advfirewall set currentprofile state on > nul
netsh advfirewall set publicprofile state on > nul
echo. 
echo 防火墙已经成功启动。
echo. 
echo. 
echo 正在关闭常见的危险端口，请稍候… 
echo. 
echo 正在关闭20,21,23,135,139,161,443,445端口… 
netsh advfirewall firewall add rule name="close_dangerous_ports_tcp" protocol=TCP dir=in localport=20,21,23,161,135,139,445 action=block
echo 正在关闭137,138端口… 
netsh advfirewall firewall add rule name="close_dangerous_ports_udp" protocol=UDP dir=in localport=137,138 action=block
echo 常见的危险端口已经关闭。 