/**
 * Created by qmjkkj001 on 2017/11/30.
 */
// 用户数据模型
var userModel = {
        'userName': '',
        'description': '',
        'sex': '',
        'birth': '',
        'email': '',
        'github': '',
        'qq': '',
        'wechat': '',
        'auth': '',
        'userId': ''
    };

var success = function (users) {}
// 请求用户信息
function getUserInfo(success) {

    console.log('请求了用户信息');
    $.ajax({
        url: host + 'getUserInfo',
        type: 'GET',
        dataType: 'JSON',
        success: function (data, status) {
            if (status == 'success') {
                var users = data.data;
                userModel = users[0];
                console.log(users);
                if (success) {
                    success(users);
                }
            }
        }
    });
}