//时间格式化工具 new Date().Format('yyyy-MM-dd hh:mm:ss')

Date.prototype.Format = function(fmt) { // author: meizz
    const o = {
        'M+': this.getMonth() + 1, // 月份
        'd+': this.getDate(), // 日
        'h+': this.getHours(), // 小时
        'm+': this.getMinutes(), // 分
        's+': this.getSeconds(), // 秒
        'q+': Math.floor((this.getMonth() + 3) / 3), // 季度
        'S': this.getMilliseconds() // 毫秒
    };
    if (/(y+)/.test(fmt)) { fmt = fmt.replace(RegExp.$1, (this.getFullYear() + '').substr(4 - RegExp.$1.length)); }
    for (const k in o) {
        if (new RegExp('(' + k + ')').test(fmt)) { fmt = fmt.replace(RegExp.$1, RegExp.$1.length === 1 ? o[k] : ('00' + o[k]).substr(('' + o[k]).length)); }
    }
    return fmt;
};

//时间差异计算
const getDateDiff = dateTimeStamp => {
    const minute = 1000 * 60;
    const hour = minute * 60;
    const day = hour * 24;
    // const halfMonth = day * 15;
    const month = day * 30;
    const now = new Date().getTime();
    const diffValue = now - dateTimeStamp;
    if (diffValue < 0) {
        return;
    }
    const monthC = diffValue / month;
    const weekC = diffValue / (7 * day);
    const dayC = diffValue / day;
    const hourC = diffValue / hour;
    const minC = diffValue / minute;
    let result;
    if (monthC >= 1) {
        result = ' ' + Math.floor(monthC) + '月前';
    } else if (weekC >= 1) {
        result = ' ' + Math.floor(weekC) + '周前';
    } else if (dayC >= 1) {
        result = ' ' + Math.floor(dayC) + '天前';
    } else if (hourC >= 1) {
        result = ' ' + Math.floor(hourC) + '小时前';
    } else if (minC >= 1) {
        result = ' ' + Math.floor(minC) + '分钟前';
    } else { result = ' 刚刚'; }
    return result;
};
