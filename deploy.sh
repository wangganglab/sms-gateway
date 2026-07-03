#!/bin/bash
# ============================================================
# sms-gateway 一键部署脚本
# 用法: bash deploy.sh
# 功能: rsync 源码到服务器 → mvn 编译 → deploy 3 实例
# ============================================================

set -e  # 任何命令失败立即退出

# === 配置 ===
SERVER="root@36.139.116.238"
SSH_PORT="65022"
REMOTE_SRC="/tools/sms/sms_platform"
LOCAL_SRC="$(cd "$(dirname "$0")/src/sms_platform" && pwd)"
JAVA_HOME_REMOTE="/tools/jdk8"

# === 颜色输出 ===
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log()   { echo -e "${GREEN}[$(date '+%H:%M:%S')]${NC} $1"; }
warn()  { echo -e "${YELLOW}[$(date '+%H:%M:%S')] ⚠️  $1${NC}"; }
error() { echo -e "${RED}[$(date '+%H:%M:%S')] ❌ $1${NC}"; exit 1; }

# === 步骤 1: rsync 源码 ===
log "步骤 1/3: rsync 源码到服务器..."
rsync -av --delete \
  --exclude 'target/' \
  --exclude '.git/' \
  --exclude 'mydata/' \
  --exclude 'docs/' \
  "$LOCAL_SRC/" \
  "$SERVER:$REMOTE_SRC/" \
  -e "ssh -p $SSH_PORT" 2>&1 | tail -5
log "rsync 完成"

# === 步骤 2: mvn 编译 ===
log "步骤 2/3: mvn 编译 (Java 8)..."
ssh -p $SSH_PORT $SERVER \
  "export JAVA_HOME=$JAVA_HOME_REMOTE && \
   cd $REMOTE_SRC && \
   mvn clean package -DskipTests -q" 2>&1 | tail -20
log "编译完成"

# === 步骤 3: 部署 ===
log "步骤 3/3: 部署 3 实例..."
ssh -p $SSH_PORT $SERVER "bash /tools/deploy-sms.sh" 2>&1 | tail -15

# === 验证 ===
log "验证服务状态..."
sleep 5
HTTP_ADMIN=$(ssh -p $SSH_PORT $SERVER "curl -s -o /dev/null -w '%{http_code}' 'http://127.0.0.1:8889/public/admin/login.jsp'")
HTTP_ENTERPRISE=$(ssh -p $SSH_PORT $SERVER "curl -s -o /dev/null -w '%{http_code}' 'http://127.0.0.1:8890/'")
HTTP_NETWAY=$(ssh -p $SSH_PORT $SERVER "curl -s -o /dev/null -w '%{http_code}' 'http://127.0.0.1:8888/'")

echo ""
log "部署完成！服务状态："
echo -e "  运营管理 (8889): ${GREEN}$HTTP_ADMIN${NC}  http://36.139.116.238:8889"
echo -e "  客户端   (8890): ${GREEN}$HTTP_ENTERPRISE${NC}  http://36.139.116.238:8890"
echo -e "  网关     (8888): ${GREEN}$HTTP_NETWAY${NC}  http://36.139.116.238:8888"
echo ""
log "访问地址: http://36.139.116.238:8889 (admin/123456)"
