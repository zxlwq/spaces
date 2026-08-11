/**
 * 监听 Uptime Kuma 已有 socket 事件
 * 目标：
 * 当后台点击“保存系统设置”时，监听官方 socket 事件，
 * 然后手动执行 rclone 备份。
 *
 * 放置：
 * server/patch-backup.js
 *
 * 启动：
 * NODE_OPTIONS="-r ./server/patch-backup.js"
 *
 * 不修改源码，Monkey Patch 模式
 */

const { exec } = require("child_process");

/**
 * 你的备份命令
 */
function runBackup(reason) {
    console.log("[Backup Trigger]", reason);

    exec("/root/kuma-backup.sh", (err, stdout, stderr) => {
        if (err) {
            console.error("[Backup Error]", stderr || err.message);
            return;
        }

        console.log("[Backup OK]");
        console.log(stdout);
    });
}

/**
 * patch socket.io 的 on()
 */
const socketio = require("socket.io");

const oldOn = socketio.Socket.prototype.on;

socketio.Socket.prototype.on = function (event, handler) {

    /**
     * Uptime Kuma 常见后台设置事件
     * （不同版本名称可能略有差异）
     */
    const watchEvents = [
        "setSettings"
    ];

    if (watchEvents.includes(event)) {

        console.log("[Hooked Event]", event);

        return oldOn.call(this, event, async (...args) => {

            try {
                // 先执行官方逻辑
                const result = await handler.apply(this, args);

                // 成功后执行备份
                runBackup(event);

                return result;

            } catch (e) {
                console.error("[Hook Error]", e);
                throw e;
            }
        });
    }

    return oldOn.call(this, event, handler);
};

console.log("Uptime Kuma socket backup hook loaded");