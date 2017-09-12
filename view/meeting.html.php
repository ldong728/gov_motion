<?php global $meetingInf ?>
<link rel="stylesheet" type="text/css" media="screen" href="stylesheet/newMain.css?v=<?php echo rand(1000, 9999) ?>">
<script src="js/edit_motion.js?t=<?php echo rand(1, 9999) ?>"></script>
<script src="js/ajaxfileupload.js?v=<?php echo rand(1000, 9999) ?>"></script>
<script>
    var staff = eval('(' + '<?php echo json_encode($_SESSION['staffLogin'])?>' + ')');
    var category =<?php echo $meetingInf['category']?>;
    var meetingId =<?php echo $meetingInf['meeting_id']?>;
    var place = 'meeting';
</script>
<style>
    .header{
        <?php if(1==$meetingInf['category']):?>
        background: url(stylesheet/images/bg-hua1.jpg) 50% 50% no-repeat;
        <?php else:?>
        background: url(stylesheet/images/bg-hua2.jpg) 50% 50% no-repeat;
        <?php endif ?>
        /*background-size: 100% 100%;*/
    }
</style>
<body>
<header class="header">
<!--    <div class="header-l"><img src="stylesheet/images/p--><?php //echo $meetingInf['category'] ?><!--.jpg" alt="logo"></div>-->
    <div class="header-r">
        <a href="#">密码修改</a>
        <a href="#" class="sign-out">退出系统</a>
    </div>
</header>

<nav class="home-nav">
    <ul class="clearfix">
        <li><a href="index.php">首页</a></li>
        <li><a href="#" class="search" data-filter="案号" data-type="int">按案号</a></li>
        <li><a href="#" class="search" data-filter="案由" data-type="string">按案由</a></li>
        <?php if (2 == $meetingInf['category']): ?>
            <li><a href="#" class="search" data-filter="性质" data-type="string">按性质</a></li><?php endif ?>
        <!--                        <td width="15%"><a href="#" class="search" >按等级时间（序列）</a></li>-->
        <li><a href="#" class="search" data-filter="性质类别<?php echo $meetingInf['category'] ?>"
               data-type="string">按性质类别</a></li>
        <li><a href="#" class="search" data-filter="状态" data-type="string">按状态</a></li>
        <li><a href="#" class="search" data-filter="<?php echo 1 == $meetingInf['category'] ? '领衔人' : '提案人' ?>"
               data-type="duty">按<?php echo 1 == $meetingInf['category'] ? '领衔人' : '提案人' ?></a></li>
        <li><a href="#" class="search" data-filter="主办单位" data-type="unit">按主办单位</a></li>
        <li><a href="#" class="search" data-filter="协办单位" data-type="unit">按协办单位</a></li>
        <li><a href="#" class="multiple-search">高级搜索</a></li>
        <?php if (in_array(3, $_SESSION['staffLogin']['steps'])): ?>
            <li><a href="#" class="get-statistics-view">统计</a></li>
        <?php endif ?>

    </ul>
    <div class="nav-right">
        <em><?php echo $_SESSION['userLogin']['user_name'] ?></em>，欢迎您登陆！
    </div>
</nav>
<!--左边-->
<section class="clearfix" id="section">
    <aside id="aside">
        <ul>
            <li><p><a href="#" class="list-filter" data-step="5"><i
                            class="icon icon-angle-right"></i>全部<span></span></a></p></li>
            <?php if (in_array(5, $_SESSION['staffLogin']['steps']) && 1 == count($_SESSION['staffLogin']['steps'])): ?>
                <li><p><a href="#" class="list-filter" data-step="5" data-filtertype="mainhandle"><i
                                class="icon icon-angle-right"></i>主办列表<span></span></a></p></li>
                <li><p><a href="#" class="list-filter" data-step="5" data-filtertype="handle"><i
                                class="icon icon-angle-right"></i>协办列表<span></span></a></p></li>
                <li><p><a href="#" class="list-filter" data-step="5" data-filtertype="can-mainhandle"><i
                                class="icon icon-angle-right"></i>主办可办<span></span></a></p></li>
                <li><p><a href="#" class="list-filter" data-step="5" data-filtertype="can-handle"><i
                                class="icon icon-angle-right"></i>协办可办<span></span></a></p></li>
            <?php endif ?>
            <?php if (in_array(3, $_SESSION['staffLogin']['steps'])): ?>
                <li><p><a href="index.php?duty_manager=1&category=<?php echo $_SESSION['staffLogin']['category']?>&meeting=<?php echo $meetingInf['meeting_id'] ?>" data-step="3" data-filtertype="mainhandle" class="duty-manager"><i
                                class="icon icon-angle-right"></i><?php echo 1 == $_SESSION['staffLogin']['category'] ? '代表名单管理' : '委员名单管理' ?>
                            <span></span></a></p></li>
                <?php if (2 == $_SESSION['staffLogin']['category']): ?>
                    <li><p><a href="#" class="multiple-statistics" data-step="3" data-filtertype="mainhandle"><i
                                    class="icon icon-angle-right"></i><span>综合统计</span></a></p></li><?php endif ?>
            <?php endif ?>
            <?php if (in_array(4, $_SESSION['staffLogin']['steps'])): ?>
                <li><p><a href="index.php?statistics_excel_out=1" class="statistics"><i
                                class="icon icon-angle-right"></i>办理统计<span></span></a></p></li>
            <?php endif ?>
            <?php if (in_array(3, $_SESSION['staffLogin']['steps']) && 1 == $_SESSION['staffLogin']['category']): ?>
                <li><p><a href="index.php?statistics_excel_out=1" class="statistics"><i
                                class="icon icon-angle-right"></i>办理统计<span></span></a></p></li>
            <?php endif ?>


        </ul>
    </aside>
    <div class="main-show">
        <span id="span-contract"><i class="icon icon-caret-left"></i></span>
    </div>
    <div class="left section-main" id="main">
        <div class="main-navbar"><h2>当前位置:<em><?php echo $meetingInf['meeting_name'] ?></em></h2></div>
        <div class="blueborder_lower">
            <div class="table-box">
                <div class="table">
                    <div class="container">
                        <div id="genetable_tableData" style="z-index: 1">
                        </div>
                    </div>
                </div>
            </div>
            <div class="table-page">
                <span class="float-left"><button class="list-output all-out">全部导出</button></span>
                <span class="float-left"><button class="list-output checked-out" >选中项导出</button></span>
                <?php if (in_array(1, $_SESSION['staffLogin']['steps'])): ?>
                    <span class="float-left"><button class="create-motion">新建<?php echo 1==$_SESSION['staffLogin']['category']?'建议/议案':'提案'?>
                    </button>
                        </span>
                <?php endif ?>

                <span class="first-page"><i class="icon icon-step-backward"></i></span>
                <span class="span-i prev-page"><i class="icon icon-caret-left"></i></span>
                <span class="current-page">1</span> <span class="total-page"></span>
                <span class="span-i next-page"><i class="icon icon-caret-right"></i></span>
                <span class="last-page"><i class="icon icon-step-forward"></i></span>
                <span>
                    <select style="width: 60px;border: 1px solid #ddd;" class="count-in-page">
                        <option value="20">20条</option>
                        <option value="30">30条</option>
                        <option value="50">50条</option>
                    </select>
                </span>
                <span class="current-num">1-15</span> <span>共<span class="span-num total-num"></span>条</span>
            </div>
        </div>
    </div>
</section>

<footer>
    <p>技术支持 <span>慈溪谷多计算机网络技术有限公司</span></p>
</footer>

<div class="m-popup popup-container clearfix" style="display: none">

</div>
<div class="search-container">
    <div class="search-mask"></div>
    <div class="input-box">
        <input type="text" class="search-input">
        <button class="search-button">重新搜索</button>
        <button class="search-button inner">在结果中搜索</button>
    </div>
</div>
<div class="popup-container popup-search field-select" style="display: none">
    <div class="mask"></div>
    <div class="term popup-title">
        <div class="title-h2">
            <h2>查询条件<i class="icon icon-close close-popup-js"></i></h2>
        </div>
        <div class="term-msg">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tbody>
                <tr class="filter-wrap-js">
                    <td class="light">姓名</td>
                    <td>曾用名</td>
                    <td>性别</td>
                    <td>教职工号</td>
                    <td>国籍/地区</td>
                    <td>身份证类型</td>
                    <td class="light">身份证号</td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="term-b">
            <button type="button" class="termbtn">确定</button>
            <button type="button" class="termbtn close-popup-js">取消</button>
        </div>
    </div>
</div>

</body>


<script type="text/javascript">
    var hasDispleasures=false;
    var total = 0;
    var totalPages = 0;
    var meetingId =<?php echo $_GET['get_meeting']?>;
    var category =<?php echo $meetingInf['category']?>;
    var orderby = 2 == staff.category ? '编号' : '案号';
    var order = true;
    var page = 0;
    var filter = {};
    var count = 20;
    var motionIdLimit = null;
</script>
<script src="js/search.js?v=<?php echo rand(1000, 9999) ?>"></script>
<script src="js/meeting.js?v=<?php echo rand(1000, 9999) ?>"></script>
<script src="js/tables.js?v=<?php echo rand(1000, 9999) ?>"></script>
</html>
