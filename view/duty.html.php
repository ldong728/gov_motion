<?php global $meetingInf ?>
<link rel="stylesheet" type="text/css" media="screen" href="stylesheet/newMain.css?v=<?php echo rand(1000, 9999) ?>">
<script src="js/edit_motion.js?t=<?php echo rand(1, 9999) ?>"></script>
<script src="js/ajaxfileupload.js?v=<?php echo rand(1000, 9999) ?>"></script>
<!--<script src="js/search.js?v=--><?php //echo rand(1000, 9999) ?><!--"></script>-->
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
     .table tr td{
         max-width: 250px;
         padding: 0 0;
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
<!--        <li><a href="#" class="search" data-filter="" data-type="int">按姓名</a></li>-->


    </ul>
    <div class="nav-right">
        <em><?php echo $_SESSION['userLogin']['user_name'] ?></em>，欢迎您登陆！
    </div>
</nav>
<!--左边-->
<section class="clearfix" id="section">
    <aside id="aside">
        <ul>
            <li><p><a href="?get_meeting=<?php echo $meetingInf['meeting_id']?>" class="list-filter" data-step="5"><i
                            class="icon icon-angle-right"></i>全部<span></span></a></p></li>
            <?php if (in_array(3, $_SESSION['staffLogin']['steps'])): ?>
                <li><p><a href="#" data-step="3" data-filtertype="mainhandle" class="duty-manager"><i
                                class="icon icon-angle-right"></i><?php echo 1 == $_SESSION['staffLogin']['category'] ? '代表名单管理' : '委员名单管理' ?>
                            <span></span></a></p></li>
                <?php if (2 == $_SESSION['staffLogin']['category']): ?>
                    <li><p><a href="#" class="multiple-statistics" data-step="3" data-filtertype="mainhandle"><i
                                    class="icon icon-angle-right"></i><span>综合统计</span></a></p></li><?php endif ?>
            <?php endif ?>
        </ul>
    </aside>
    <div class="main-show">
        <span id="span-contract"><i class="icon icon-caret-left"></i></span>
    </div>
    <div class="left section-main" id="main">
        <div class="main-navbar"><h2>当前位置:<em><?php echo $meetingInf['meeting_name'] ?> 名单管理</em></h2></div>
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
<!--                <span class="float-left"><button class="list-output all-out">全部导出</button></span>-->
<!--                <span class="float-left"><button class="list-output checked-out" >选中项导出</button></span>-->
                <?php if (in_array(1, $_SESSION['staffLogin']['steps'])): ?>
                    <span class="float-left"><button class="create-user">新建<?php echo 1==$_SESSION['staffLogin']['category']?'代表':'委员'?>
                        </button>
                        </span>
                <?php endif ?>

<!--                <span class="first-page"><i class="icon icon-step-backward"></i></span>-->
<!--                <span class="span-i prev-page"><i class="icon icon-caret-left"></i></span>-->
<!--                <span class="current-page">1</span> <span class="total-page"></span>-->
<!--                <span class="span-i next-page"><i class="icon icon-caret-right"></i></span>-->
<!--                <span class="last-page"><i class="icon icon-step-forward"></i></span>-->
<!--                <span>-->
<!--                    <select style="width: 60px;border: 1px solid #ddd;" class="count-in-page">-->
<!--                        <option value="20">20条</option>-->
<!--                        <option value="30">30条</option>-->
<!--                        <option value="50">50条</option>-->
<!--                    </select>-->
<!--                </span>-->
<!--                <span class="current-num">1-15</span> <span>共<span class="span-num total-num"></span>条</span>-->
            </div>
        </div>
    </div>
</section>

<footer>
    <p>技术支持 <span>慈溪谷多计算机网络技术有限公司</span></p>
</footer>

<div class="m-popup popup-container clearfix">
    abced
</div>
<div class="search-container">
    <div class="search-mask"></div>
    <div class="input-box">
        <input type="text" class="search-input">
        <button class="search-button">重新搜索</button>
        <button class="search-button inner">在结果中搜索</button>
    </div>
</div>


</body>


<script type="text/javascript">
    var total = 0;
    var totalPages = 0;
    var meetingId =<?php echo $_GET['meeting']?>;
    var category =<?php echo $meetingInf['category']?>;
//    var orderby = 2 == staff.category ? '编号' : '案号';
    var order = true;
    var page = 0;
    var filter = {};
    var count = 20;
    var motionIdLimit = null;
    var userUnit={};
    var userGroup={};
</script>
<script src="js/duty.js?v=<?php echo rand(1000, 9999) ?>"></script>
<script src="js/tables.js?v=<?php echo rand(1000, 9999) ?>"></script>
</html>
