#!/bin/bash

#修改默认主题
sed -i "s/luci-theme-bootstrap/luci-theme-argon/g" $(find ./feeds/luci/collections/ -type f -name "Makefile")


# 设置root密码为password
# shadow文件里的字段格式和解释：
# {用户名}：{加密后的口令密码}：{口令最后修改时间距原点(1970-1-1)的天数}：{口令最小修改间隔(防止修改口令，如果时限未到，将恢复至旧口令)：{口令最大修改间隔}：{口令失效前的警告天数}：{账户不活动天数}：{账号失效天数}：{保留}
# 如果密码字符串为*， 表示系统用户不能被登入;   为！，表示用户名被禁用;   为空，表示没有密码
# 可以用 $passwd -d 用户名  清空一个用户的密码

# 密码加密算法，其实就是用明文密码和一个叫salt的东西通过函数crypt()完成加密。
# 密码域密文也是由三部分组成的，即：$id$salt$encrypted。
# id为1时，采用md5进行加密；id为5时，采用SHA256进行加密；id为6时，采用SHA512进行加密。
# $salt 是一个最多16个字符的随机生成的字符串，增加破解难度。$encrypted 就是通过id算法和盐算出来的密文了
# 命令行或在线perl工具生成密码字符串：perl -e 'print crypt("password",q($1$V4UetPzk)),"\n"';
# 生成密文$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.
# sed -i 's/root:::0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' package/base-files/files/etc/shadow


# 修改默认密码password
#sed -i 's/root::0:0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' package/base-files/files/etc/shadow
#sed -i 's/root:::0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' package/base-files/files/etc/shadow

# 修改默认IP & 固件名称 & 编译署名 &#添加编译日期标识
#sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate
sed -i "s/hostname='.*'/hostname='JDC'/g" package/base-files/files/bin/config_generate
sed -i "s/(\(luciversion || ''\))/(\1) + (' \/ Built by lee29')/g" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js

# 修改本地时间格式
#sed -i 's/os.date()/os.date("%a %Y-%m-%d %H:%M:%S")/g' package/lean/autocore/files/*/index.htm

# 调整NSS驱动q6_region内存区域预留大小（ipq6018.dtsi默认预留85MB，ipq6018-512m.dtsi默认预留55MB，以下分别是改成预留16MB、32MB、64MB和96MB）
# sed -i 's/reg = <0x0 0x4ab00000 0x0 0x[0-9a-f]\+>/reg = <0x0 0x4ab00000 0x0 0x01000000>/' target/linux/qualcommax/files/arch/arm64/boot/dts/qcom/ipq6018-512m.dtsi
# sed -i 's/reg = <0x0 0x4ab00000 0x0 0x[0-9a-f]\+>/reg = <0x0 0x4ab00000 0x0 0x02000000>/' target/linux/qualcommax/files/arch/arm64/boot/dts/qcom/ipq6018-512m.dtsi
# sed -i 's/reg = <0x0 0x4ab00000 0x0 0x[0-9a-f]\+>/reg = <0x0 0x4ab00000 0x0 0x04000000>/' target/linux/qualcommax/files/arch/arm64/boot/dts/qcom/ipq6018-512m.dtsi
#sed -i 's/reg = <0x0 0x4ab00000 0x0 0x[0-9a-f]\+>/reg = <0x0 0x4ab00000 0x0 0x06000000>/' target/linux/qualcommax/files/arch/arm64/boot/dts/qcom/ipq6018-512m.dtsi



# 修改 luci 文件，添加 NSS Load 相关状态显示
#sed -i "s#const fd = popen('top -n1 | awk \\\'/^CPU/ {printf(\"%d%\", 100 - \$8)}\\\'')#const fd = popen(access('/sbin/cpuinfo') ? '/sbin/cpuinfo' : \"top -n1 | awk \\'/^CPU/ {printf(\"%d%\", 100 - \$8)}\\'\")#g"
# samba 解除 root 限制
#sed -i 's/invalid users = root/#&/g' feeds/packages/net/samba4/files/smb.conf.template

# 更改默认 Shell 为 zsh
# sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd

# TTYD 免登录
#sed -i 's|/bin/login|/bin/login -f root|g' feeds/packages/utils/ttyd/files/ttyd.config







# 移除要替换的包
rm -rf feeds/luci/applications/luci-app-appfilter
#rm -rf feeds/luci/applications/luci-app-frpc
#rm -rf feeds/luci/applications/luci-app-frps
rm -rf feeds/packages/net/open-app-filter
rm -rf feeds/packages/net/adguardhome
rm -rf feeds/packages/net/ariang
#rm -rf feeds/packages/net/frp
rm -rf feeds/packages/lang/golang


#公用函数
source $GITHUB_WORKSPACE/scripts/functions.sh


#添加迅雷下载
git clone --depth=1 https://github.com/lee29/xunlei-package package/xunlei



# Go & OpenList & ariang & frp & AdGuardHome & WolPlus & Lucky & OpenAppFilter & 集客无线AC控制器 & 雅典娜LED控制
git clone --depth=1 https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang
git clone --depth=1 https://github.com/sbwml/luci-app-openlist2 package/openlist
git_sparse_clone ariang https://github.com/laipeng668/packages net/ariang
#git_sparse_clone frp https://github.com/laipeng668/packages net/frp
#mv -f package/frp feeds/packages/net/frp
#git_sparse_clone frp https://github.com/laipeng668/luci applications/luci-app-frpc applications/luci-app-frps
#mv -f package/luci-app-frpc feeds/luci/applications/luci-app-frpc
#mv -f package/luci-app-frps feeds/luci/applications/luci-app-frps
git_sparse_clone master https://github.com/kenzok8/openwrt-packages adguardhome luci-app-adguardhome
git_sparse_clone main https://github.com/VIKINGYFY/packages luci-app-wolplus
git clone --depth=1 https://github.com/gdy666/luci-app-lucky package/luci-app-lucky
git clone --depth=1 https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
git clone --depth=1 https://github.com/lwb1978/openwrt-gecoosac package/openwrt-gecoosac
git clone --depth=1 https://github.com/NONGFAH/luci-app-athena-led package/luci-app-athena-led
chmod +x package/luci-app-athena-led/root/etc/init.d/athena_led package/luci-app-athena-led/root/usr/sbin/athena-led


# OpenClash（ dev 版 ）
#rm -rf feeds/luci/applications/luci-app-openclash
#git clone --depth=1 -b dev https://github.com/vernesong/OpenClash.git package/luci-app-openclash

# iStore
#git_sparse_clone main https://github.com/linkease/istore-ui app-store-ui
#git_sparse_clone main https://github.com/linkease/istore luci



./scripts/feeds update -a
./scripts/feeds install -a


#内置openclash文件
mkdir -p files/etc/openclash/core
CLASH_META_URL="https://raw.githubusercontent.com/vernesong/OpenClash/core/dev/smart/clash-linux-arm64.tar.gz"
GEOIP_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat"
GEOSITE_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat"
COUNTRY_URL="https://raw.githubusercontent.com/alecthw/mmdb_china_ip_list/release/Country.mmdb"
ASN_URL="https://raw.githubusercontent.com/xishang0128/geoip/release/GeoLite2-ASN.mmdb"
MODEL_URL="https://github.com/vernesong/mihomo/releases/download/LightGBM-Model/model-large.bin"
# wget -qO- $CLASH_META_URL | gzip -d > files/etc/openclash/core/mihomo-linux-amd64
wget -qO- $CLASH_META_URL | tar xOvz > files/etc/openclash/core/clash_meta
wget -qO- $GEOIP_URL > files/etc/openclash/GeoIP.dat
wget -qO- $GEOSITE_URL > files/etc/openclash/GeoSite.dat
wget -qO- $COUNTRY_URL > files/etc/openclash/Country.mmdb
wget -qO- $ASN_URL > files/etc/openclash/ASN.mmdb
wget -qO- $MODEL_URL > files/etc/openclash/model.bin
chmod +x files/etc/openclash/core/clash*




#内置订阅转换后端服务
#【https://github.com/Aethersailor/Custom_OpenClash_Rules/wiki/%E4%B8%80%E4%BA%9B%E9%9B%B6%E7%A2%8E%E7%9A%84%E6%95%99%E7%A8%8B#11-immortalwrt-%E4%B8%8B%E6%90%AD%E5%BB%BA%E8%AE%A2%E9%98%85%E8%BD%AC%E6%8D%A2%E5%90%8E%E7%AB%AF%E6%9C%8D%E5%8A%A1】
mkdir -p files/etc/subconverter/config
SMART_INI_URL="https://raw.githubusercontent.com/Aethersailor/Custom_OpenClash_Rules/main/cfg/Custom_Clash_Smart_Lite.ini"
wget -qO- $SMART_INI_URL > files/etc/subconverter/config/Smart.ini
chmod +x files/etc/subconverter/config/Smart.ini

# 调整插件显示位置
# sed -i 's/services/system/g' feeds/luci/applications/luci-app-ttyd/root/usr/share/luci/menu.d/luci-app-ttyd.json
sed -i 's/services/nas/g' package/openlist/luci-app-openlist2/root/usr/share/luci/menu.d/luci-app-openlist2.json
# sed -i 's/services/nas/g' feeds/luci/applications/luci-app-samba4/root/usr/share/luci/menu.d/luci-app-samba4.json
# sed -i 's/services/nas/g' feeds/luci/applications/luci-app-hd-idle/root/usr/share/luci/menu.d/luci-app-hd-idle.json
# sed -i 's/services/nas/g' feeds/luci/applications/luci-app-minidlna/root/usr/share/luci/menu.d/luci-app-minidlna.json
# sed -i 's/services/control/g' feeds/luci/applications/luci-app-eqos/root/usr/share/luci/menu.d/luci-app-eqos.json
# sed -i 's/services/control/g' feeds/luci/applications/luci-app-wol/root/usr/share/luci/menu.d/luci-app-wol.json
# sed -i 's/services/control/g' feeds/luci/applications/luci-app-wifischedule/root/usr/share/luci/menu.d/luci-app-wifischedule.json




./scripts/feeds update -a
./scripts/feeds install -a


