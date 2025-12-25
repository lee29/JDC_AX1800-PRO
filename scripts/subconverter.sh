# Git稀疏克隆，只克隆指定目录到本地
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}


###----------------------------------------------------------------------
# 移除 subconverter核心库
# rm -rf feeds/packages/libs/{jpcre2,libcron,quickjspp,rapidjson,toml11}
# rm -rf feeds/packages/net/{sub-web,subconverter}
# git_sparse_clone master https://github.com/Dawneng/openwrt-subconverter jpcre2 feeds/packages/libs/jpcre2
# git_sparse_clone master https://github.com/Dawneng/openwrt-subconverter libcron feeds/packages/libs/libcron
# git_sparse_clone master https://github.com/Dawneng/openwrt-subconverter quickjspp feeds/packages/libs/quickjspp
# git_sparse_clone master https://github.com/Dawneng/openwrt-subconverter rapidjson feeds/packages/libs/rapidjson
# git_sparse_clone master https://github.com/Dawneng/openwrt-subconverter toml11 feeds/packages/libs/toml11
# git_sparse_clone master https://github.com/Dawneng/openwrt-subconverter sub-web feeds/packages/net/sub-web
# git_sparse_clone master https://github.com/Dawneng/openwrt-subconverter subconverter feeds/packages/net/subconverter
# chmod +x feeds/packages/libs/{jpcre2,libcron,quickjspp,rapidjson,toml11}
# chmod +x feeds/packages/net/{sub-web,subconverter}
# ### 添加 luci-app-subconverter 订阅转换界面
# git_sparse_clone main https://github.com/0x2196f3/luci-app-subconverter feeds/luci/applications/luci-app-subconverter
# chmod +x feeds/luci/applications/luci-app-subconverter


#subconverter
git clone --depth=1 https://github.com/Dawneng/openwrt-subconverter package/subconverter
git clone --depth=1 https://github.com/0x2196f3/luci-app-subconverter package/luci-app-subconverter


./scripts/feeds update -a
./scripts/feeds install -a
