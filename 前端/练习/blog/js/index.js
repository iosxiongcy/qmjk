/**
 * Created by qmjkkj001 on 2017/11/29.
 */


$(function () {

    // 博客数据模型
    var blogDict = {
        data: [],
        errMsg: '',
        status: '',
        totalPage: 0,
    }
    var blogList = []
    var blogData = {
        'blogId': 1,
        'title': '',
        'description': '',
        'releaseTime': '',
        'category': '',
    }
    var currentPage = 1;  // 当前页数
    var totalPage = 0;    // 总页数
    var pageSize = 5;     // 每页的数量

// 根据pageSize创建view
    $(function () {

        var mainView = $('.main-content');//主view
        for (var i = 0; i < pageSize; i ++) {
            // 克隆view
            var cloneView = $('#main-item').clone(true);
            cloneView.attr('id', 'main-item'+i);
            mainView.append(cloneView);
        }
        $('#main-item').remove();

    });

// 获取用户数据
    publicUserInfo(function (users) {
        changeViewWithUserInfo(users);
    });

// 根据当前页数获取博客数据
    function getBlogs() {
        $.ajax({
            url: host + 'getAllBlog',
            type: 'POST',
            dataType: 'JSON',
            data: {'userId':  '1', 'pageIndex': currentPage, 'pageSize': 5},
            success: function (data, status) {
                if (status == 'success') {
                    var blogs = data.data;
                    blogDict = data;
                    totalPage = blogDict.totalPage;
                    blogList = blogList.concat(blogs);

                    console.log('获取到的博客--'+blogList[0].blogId);
                    changePageState();
                    changeViewWithBlogs();
                }
            }
        });
    }
    getBlogs();

// 根据用户信息修改页面展示
    function changeViewWithUserInfo(users) {
        var user = users[0];
        console.log('获取到用户信息--' + user.userName);
        // var navTitleElement = $('.navbar-brand');
        // 获取描述里用户名称标签
        var descNameElement = $('.main-item').find('#desc-user');

        // navTitleElement.html(user.userName);
        descNameElement.html(user.userName);

    }
// 根据博客数据修改页面
    function changeViewWithBlogs() {

        console.log('当前页数--'+currentPage);
        // 先清空数据
        for (var i = 0; i < pageSize; i ++) {
            var view = $('.main-item');
            view.addClass('hidden');
        }

        var blogs = blogList.slice((currentPage-1)*5, (currentPage-1)*5 + pageSize);

        for (i in blogs) {
            var view = $('.main-item').eq(i);
            view.removeClass('hidden');
            // 获取标题标签
            var titleElement = view.find('h2');
            // 获取描述标签
            var descElement = view.find('p');
            // 获取描述里时间标签
            var timeElement = view.find('#desc-time');
            // 获取描述里分类标签
            var categoryElement = view.find('#desc-category');

            // 数据
            var blog = blogs[i];
            console.log('博客数据--'+blog.category);

            // 设置值
            titleElement.html(blog.title);
            descElement.html(blog.description);
            // user.html(blog.u)
            timeElement.html(toDateString(blog.releaseTime).replace('/', '-').replace('/','-'));
            categoryElement.html(blog.category);
        }
    }

    function changePageState() {
        // 显示/隐藏 下一页/上一页
        console.log('总页数'+totalPage);
        if (totalPage > 1) {
            $('.next').removeClass('hidden');
        }
        if (currentPage == 1) {
            $('.previous').addClass('hidden');
        }
        console.log('当前页数--'+currentPage+'总页数--'+totalPage);
        if (currentPage > 1) {
            $('.previous').removeClass('hidden');
        }
        if (totalPage == currentPage) {
            $('.next').addClass('hidden');
        }
    }

    // 下一页/上一页点击事件
    $('.previous').on('click', function () {
        currentPage --;
        console.log('点击上一页后当前页面--'+currentPage);
        changeViewWithBlogs();
        changePageState();
    });
    $('.next').on('click', function () {
        currentPage ++;
        console.log('点击下一页后当前页面--'+currentPage);
        if (blogList.length > (currentPage-1) * pageSize) {
            // 如果blogList的数量大于 currentPage*pageSize, 则取本地数据
            // 省去网络请求
            changeViewWithBlogs();
            console.log('不从服务器请求博客数据,本地获取');
        } else {
            // 否则,从服务器请求数据
            getBlogs();
            console.log('从服务器请求博客数据');
        }
        changePageState();
    });
})
