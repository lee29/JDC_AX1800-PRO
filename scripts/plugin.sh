# 调整插件显示位置
# sed -i 's/services/system/g' feeds/luci/applications/luci-app-ttyd/root/usr/share/luci/menu.d/luci-app-ttyd.json
sed -i 's/services/nas/g' package/openlist2/luci-app-openlist2/root/usr/share/luci/menu.d/luci-app-openlist2.json
# sed -i 's/services/nas/g' feeds/luci/applications/luci-app-samba4/root/usr/share/luci/menu.d/luci-app-samba4.json
# sed -i 's/services/nas/g' feeds/luci/applications/luci-app-hd-idle/root/usr/share/luci/menu.d/luci-app-hd-idle.json
# sed -i 's/services/nas/g' feeds/luci/applications/luci-app-minidlna/root/usr/share/luci/menu.d/luci-app-minidlna.json
# sed -i 's/services/control/g' feeds/luci/applications/luci-app-eqos/root/usr/share/luci/menu.d/luci-app-eqos.json
# sed -i 's/services/control/g' feeds/luci/applications/luci-app-wol/root/usr/share/luci/menu.d/luci-app-wol.json
# sed -i 's/services/control/g' feeds/luci/applications/luci-app-wifischedule/root/usr/share/luci/menu.d/luci-app-wifischedule.json

./scripts/feeds update -a
./scripts/feeds install -a