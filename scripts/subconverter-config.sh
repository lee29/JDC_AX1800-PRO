# Git稀疏克隆，只克隆指定目录到本地
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}


#内置订阅转换后端服务
#【https://github.com/Aethersailor/Custom_OpenClash_Rules/wiki/%E4%B8%80%E4%BA%9B%E9%9B%B6%E7%A2%8E%E7%9A%84%E6%95%99%E7%A8%8B#11-immortalwrt-%E4%B8%8B%E6%90%AD%E5%BB%BA%E8%AE%A2%E9%98%85%E8%BD%AC%E6%8D%A2%E5%90%8E%E7%AB%AF%E6%9C%8D%E5%8A%A1】
mkdir -p files/etc/subconverter/config
SMART_INI_URL="https://testingcf.jsdelivr.net/gh/Aethersailor/Custom_OpenClash_Rules@main/cfg/Custom_Clash_Lite.ini"
wget -qO- $SMART_INI_URL > files/etc/subconverter/config/Smart.ini
chmod +x files/etc/subconverter/config/Smart.ini

./scripts/feeds update -a
./scripts/feeds install -a