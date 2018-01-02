/**
 * Created by qmjkkj001 on 2017/12/4.
 */

// 获取用户信息
publicUserInfo(function (users) {


});

$(function () {

    var blogModel = {
        'blogId': '',
        'title': '',
        'description': '',
        'text': '',
        'releaseTime': ''
    };
    var blogId = '15';
    var blogView = $('.blog-main');

    function getBlogWithId() {
        $.ajax({
            url: host + 'getBlogWithId',
            type: 'POST',
            dataType: 'JSON',
            data: { 'blogId' : blogId },
            success: function (data, status) {
                if (status == 'success') {
                    // 设置网页标题
                    document.title = data.title;
                    console.log('根据id'+blogId+'获取到文章'+data.data);
                    blogView.html('<h2 style="text-align: center;">' +
                        data.title +
                        '</h2>' +
                        '<br>' + data.text);
                }
            }
        })
    }

    getBlogWithId();

});