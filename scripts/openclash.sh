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
#内置openclash文件
mkdir -p files/etc/openclash/core
CLASH_META_URL="https://raw.githubusercontent.com/vernesong/OpenClash/core/dev/smart/clash-linux-arm64.tar.gz"
GEOIP_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat"
GEOSITE_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat"
COUNTRY_URL="https://raw.githubusercontent.com/alecthw/mmdb_china_ip_list/release/Country.mmdb"
ASN_URL="https://raw.githubusercontent.com/xishang0128/geoip/release/GeoLite2-ASN.mmdb"
MODEL_URL="https://github.com/vernesong/mihomo/releases/download/LightGBM-Model/Model-large.bin"
# wget -qO- $CLASH_META_URL | gzip -d > files/etc/openclash/core/mihomo-linux-amd64
wget -qO- $CLASH_META_URL | tar xOvz > files/etc/openclash/core/clash_meta
wget -qO- $GEOIP_URL > files/etc/openclash/GeoIP.dat
wget -qO- $GEOSITE_URL > files/etc/openclash/GeoSite.dat
wget -qO- $COUNTRY_URL > files/etc/openclash/Country.mmdb
wget -qO- $ASN_URL > files/etc/openclash/ASN.mmdb
wget -qO- $MODEL_URL > files/etc/openclash/model.bin
chmod +x files/etc/openclash/core/clash*


./scripts/feeds update -a
./scripts/feeds install -a