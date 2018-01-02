/**
 * Created by qmjkkj001 on 2017/11/30.
 */
// var host = 'https://xiongcy.herokuapp.com/blog/';
var host = 'http://127.0.0.1:8000/blog/';


// 将字符串转成正常的时间字符串
function toDateString(str) {
    // console.log('原始时间--'+str);
    var time = Date.parse(new Date(str));
    var newDate = new Date();
    newDate.setTime(time);
    // console.log('转成Date类型--'+time);
    var timeStr = newDate.toLocaleDateString();
    // console.log('最终的时间字符串--'+ timeStr);
    return timeStr;
}