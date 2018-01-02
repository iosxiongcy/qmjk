/**
 * Created by qmjkkj001 on 2017/12/1.
 */
/******* 网页的公共内容 *******/

/* 公共的根据用户信息设置导航 */
function publicUserInfo(success) {
    getUserInfo(function (users) {
        changeViewWithUserInfo(users);
        if (success) {
            success(users);
        }
    })
}

// 根据用户信息修改导航条Brand
function changeViewWithUserInfo(users) {
    var user = users[0];
    console.log('获取到用户信息--' + user.userName);
    var navTitleElement = $('.navbar-brand');

    navTitleElement.html(user.userName);
}

$(function () {

    // 展示公共样式
    var createHeader = function () {
        var div = $('<div class="navbar navbar-default navbar-fixed-top blog-navbar">' +
                '<div class="navbar-header">' +
                    '<button type="button" class="navbar-toggle collapsed" data-target="#navbar-content" data-toggle="collapse" aria-expanded="false">' +
                        '<span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>' +
                    '</button>' +
                    '<a href="" class="navbar-brand"></a>' +
                '</div>'+
                '<div class="collapse navbar-collapse" id="navbar-content">' +
                    '<ul class="nav navbar-nav navbar-right">' +
                        '<li><a href="">分类</a></li><li><a href="">关于</a></li>' +
                    '</ul>' +
                '</div>' +
            '</div>');

        $('header').append(div);
    }

    var createFooter = function () {
        $('footer').addClass('footer-bg');
        var div = $('<div class="container footer-content"><span>Copyright ©</span><i>2017 </i><span>draven</span></div>');
        $('footer').append(div);
    }

    createHeader();
    createFooter();

    // 获取用户数据
    // getUserInfo(function (users) {
    //     changeViewWithUserInfo(users);
    // });



    // 页面跳转
    // 主页
    $('.navbar-header').find('a').attr('href', 'index.html');
    // 分类
    $('.navbar-collapse').find('a').eq(0).attr('href', 'html/category.html');
    // 关于
    $('.navbar-collapse').find('a').eq(1).attr('href', 'html/category.html');

});
