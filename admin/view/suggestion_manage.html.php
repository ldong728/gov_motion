<style>
    td {
        max-width: 300px;
        word-spacing: normal;
        overflow: hidden;
        text-overflow: ellipsis;
        display;
        -webkit-box;
        /*-webkit-box-orient:*/
        -webkit-line-clamp: 2;
    }

    .content-container {
        display: none;
        top: 0px;
        left: 0px;
        position: absolute;
        width: 500px;
        /*min-height: 50px;*/
        z-index: 100;
        background-color: #ddd;
    }

    .content-container .content {
        margin: 0;
        padding: 15px;
        max-height: 500px;
        /*overflow: scroll;*/

    }

    .option-box {

        height: 40px;
        /*background-color: #080808;*/
    }

    .button-box {
        text-align: center;
        align-content: center;
        float: left;
        box-sizing: border-box;
        height: 30px;
        width: 33%;
    }

    .button-box button {
        width: 100px;
        /*letter-spacing: 5px;*/
    }
</style>
<div id="core" style="height: 658px;">
    <div class="block">
        <div class="head" style="width: 98%;"><span>提案线索管理</span></div>
        <div class="main">
            <table class="table sheet unit-table">
                <tr class="h list-head">
                    <td>姓名</td>
                    <td>联系电话</td>
                    <td>ip地址</td>
                    <td>提交时间</td>
                    <td>性质类别</td>
                    <td>内容</td>
                    <td>操作</td>
                </tr>
                <tr class="unit-table-foot">
                    <td colspan="7">
                        <div class="page_link">
                            <div class="in">
                                <a href="#" class="page-change" id="prev">上一页</a>
                                <span>共<span class="page-total"></span>页</span>
                                <span>当前第<span class="page-now" id="next"></span>页</span>
                                <a href="#" class="page-change" id="next">下一页</a>
                                <!--                                <input class="text" type="text" style="width:30px" name="page" value="1">-->
                                <!--                                <input class="button" type="button" value="跳转">-->
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>

    </div>
    <div class="main">
        <table class="table sheet">
            <tbody>
            <tr>
                <td>筛选：</td>
                <td>审核状态筛选：<select class="status-filter">
                        <option value="all">全部</option>
                        <option value="1">已通过</option>
                        <option value="0">待审核</option>
                    </select>
                </td>
                <td>性质类别筛选：<select class="type-filter">
                        <option value="all">全部</option>
                        <option value="工业经济">工业经济</option>
                        <option value="农林水利">农林水利</option>
                        <option value="财贸金融">财贸金融</option>
                        <option value="道路交通">道路交通</option>
                        <option value="城建管理">城建管理</option>
                        <option value="环境保护">环境保护</option>
                        <option value="医药卫生">医药卫生</option>
                        <option value="科技教育">科技教育</option>
                        <option value="文化体育">文化体育</option>
                        <option value="劳动人事">劳动人事</option>
                        <option value="政法统战">政法统战</option>
                        <option value="其他">其他</option>

                </select>
                </td>
            </tr>
            </tbody>
        </table>
    </div>

</div>

<div class="content-container">
    <div class="content"></div>
    <div class="option-box">
        <div class="button-box">
            <button class="detail-pass pass">通过审核</button>
        </div>
        <div class="button-box">
            <button class="detail-delete delete">删&nbsp;&nbsp;&nbsp;&nbsp;除</button>
        </div>
        <div class="button-box">
            <button class="close">返&nbsp;&nbsp;&nbsp;&nbsp;回</button>
        </div>
    </div>
</div>

<script>
    var page = 0;
    var orderby = 'update_time';
    var order = true;
    var where = {status: [0, 1]};
    var totalPage = 0;
    var contentList = {};
    $(document).ready(function () {
        getSuggestionList();
        $('.page-change').click(function () {
            if ('prev' == $(this).attr('id') && page > 0) {
                page--;
                getSuggestionList();
            }
            if ('next' == $(this).attr('id') && page < totalPage - 1) {
                page++;
                getSuggestionList();
            }
        });
        $(document).on('click', '.display-content', function () {
            var id = this.id.slice(3);
            $('.content').text(contentList[id]);
            $('.detail-pass').attr('id', 'pas' + id);
            $('.detail-delete').attr('id', 'del' + id);
            $('.content-container').show()
        });
        $(document).on('click', '.close', function () {
            $('.content-container').hide();
        });
        $(document).on('click', '.pass', function () {
            var id = this.id.slice(3);
            altTable('suggestion', 'status', 1, 'suggestion_id', id, function (data) {
                $('.content-container').hide();
                getSuggestionList();
//           showToast('通过审核')
            });
        });
        $(document).on('click', '.delete', function () {
            if (confirm('确定要删除吗？')) {
                var id = this.id.slice(3);
                altTable('suggestion', 'status', 9, 'suggestion_id', id, function (data) {
                    getSuggestionList();
                });
            }

        });
        $(document).on('change', '.status-filter', function () {
            var status = this.value;
            if ('all' == status)where = {status: [0, 1]};
            else where.status = status;
            getSuggestionList();
        });
        $(document).on('change', '.type-filter', function () {
            var type = this.value;
            if ('all' == type)where.remove('type');
            else where.type = type;

            console.log(where);
            getSuggestionList();
        });
        initContentContainer();
    });

    function getSuggestionList() {
//            var cateName=['属性选择','人大','政协','综合'];
        var orderStr = order ? 'asc' : 'desc';
        var whereValue = where || null;

        ajaxPost('reflashSuggestionList', {
            orderby: orderby,
            order: orderStr,
            page: page,
            where: whereValue
        }, function (data) {
            var backInf = backHandle(data);
//                console.log(backInf.page);
            $('.list-row').remove();

            $.each(backInf.list, function (k, v) {
                var status = v.status;
                var button = '<button class="pass button" id="pas' + v.suggestion_id + '">通过审核</button>';
                switch (status) {
                    case '1':
                        button = '';
                        break;
                }
                var content = '<tr class="list-row" id="row' + v.suggestion_id + '">' +
                    '<td>' + v.name + '</td>' +
                    '<td>' + v.tel + '</td>' +
                    '<td>' + v.from_ip + '</td>' +
                    '<td>' + v.update_time + '</td>' +
                    '<td>' + v.type + '</td>' +
                    '<td><button class="display-content" id="dis' + v.suggestion_id + '">显示</button></td>' +
                    '<td>' + button + '<button class="delete button" id="del+' + v.suggestion_id + '">删除</button></td></tr>';
                $('.unit-table-foot').before(content);
                contentList[v.suggestion_id] = v.content;
            });

            totalPage = backInf.page;
            $('.page-total').text(totalPage);
            $('.page-now').text(page + 1);
        });
    }
    function initContentContainer() {

//        var pHeight=document.documentElement.clientHeight;
        var parent = $('.content-container').parent();
        var pHeight = parent.height();
        var pWidth = parent.width();
        $('.content-container').width(pWidth / 3 * 2);
//        $('.content-container').height(pHeight/3*2);
        $('.content-container').css('top', (pHeight / 6) + 'px');
        $('.content-container').css('left', (pWidth / 6) + 'px');
        console.log(pWidth);
        console.log(pHeight);
    }
</script>