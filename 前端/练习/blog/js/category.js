/**
 * Created by qmjkkj001 on 2017/12/1.
 */


$(function () {

    var dataModel = {
            'categoryName': '',
            'blogs': [
                {
                    'time': '',
                    'blogTitle': '',
                },
            ],
        };
    
    var datas = [];

    publicUserInfo(function (users) {
        $.ajax({
            url: host + 'getCategoryMapBlog',
            type: 'POST',
            data: {'userId': users[0].userId},
            dataType: 'JSON',
            success: function (data, status) {
                if (status == 'success') {
                    console.log(data);
                    datas = data.data;
                    changeView();
                }
            }
        });
    })

    function changeView() {
        var mainView = $('.ct-main');

        for (i in datas) {
            var data = datas[i];
            var blogs = data.blogs;

            var view = $('<div class="category"></div>')
            // 分类标题
            var titleElement = $('<h2></h2>').html(data.categoryName);
            // 博客时间和名称列表
            var ulElement = $('<ul></ul>');
            for (b in blogs) {
                var blog = blogs[b];
                var liElement = $('<li></li>');
                var timeElement = $('<time></time>');
                var aElement = $('<a></a>');
                timeElement.html(toDateString(blog.releaseTime));
                aElement.html(blog.title);
                liElement.append(timeElement, aElement);
                ulElement.append(liElement);
            }
            view.append(titleElement, ulElement);
            mainView.append(view);
        }
    }

});