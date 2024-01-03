# For rk3588 docker android gpu & mpp 硬编解码 
## 创建项目&拉取代码

```bash
# 创建目录
mkdir ~/aniyo && cd ~/aniyo
# 拉取aosp代码
repo init -u https://android.googlesource.com/platform/manifest --git-lfs --depth=1 -b android-14.0.0_r15
# 拉取local_manifests
git clone https://github.com/playzyx/local_manifests.git ~/aniyo/.repo/local_manifests -b android-14
# 执行脚本生成xml
./.repo/local_manifests/generate_remove_projects.sh ~/aniyo/.repo/manifests/default.xml ~/aniyo/.repo/local_manifests/aniyo.xml
# 同步源码
repo sync -c --no-repo-verify -j24
```
