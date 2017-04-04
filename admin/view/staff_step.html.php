<?php global $superUnit?>

<div id="core" style="height: 658px;">
    <div class="block">
        <div class="head" style="width: 98%;"><span>操作员流程权限控制</span></div>
        <div class="main">
            <table class="table sheet unit-table">
                <tr class="h">
                    <td rowspan="2">id</td>
                    <td rowspan="2">全名</td>
                    <td rowspan="2">单位</td>
                    <td rowspan="2" class="order" data-orderby="out_id">来源</td>
                    <td colspan="6">流程权限</td>
                    <td rowspan="2">分组</td>
                    <td rowspan="2">操作</td>
                </tr>
                <tr>
                    <td>提交</td>
                    <td>登记</td>
                    <td>审核</td>
                    <td>交办</td>
                    <td>办理</td>
                    <td>反馈</td>
                </tr>
                <tr class="list-row">
                    <td>abc</td>
                    <td>abc</td>
                    <td>abc</td>
                    <td>abc</td>
                    <td>abc</td>
                    <td>abc</td>
                    <td>abc</td>
                    <td>abc</td>
                    <td>abc</td>
                    <td>abc</td>
                    <td>abc</td>
                </tr>
                <tr class="unit-table-foot">
                    <td colspan="12">
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
                        <!-- GOODUO -->
                    </td>
                </tr>
            </table>
        </div>

    </div>
    <div class="main">
        <table class="table sheet">
            <tr>
                <td>筛选：</td>
                <td><input type="text" class="search-input"><button class="search-button">按名称搜索</button> </td>
                <td>按单位筛选：<select class="super-unit"><option value="0">选择单位</option>
                    <?php foreach($superUnit as $row):?>
                        <option value="<?php echo $row['id']?>"><?php echo $row['name']?></option>
                        <?php endforeach ?>
                    </select></td>
                <td>
                    按流程筛选：
                    <select class="step-filter">
                        <option value="0">选择流程</option>
                        <option value="1">提交</option>
                        <option value="2">登记</option>
                        <option value="3">审核</option>
                        <option value="4">交办</option>
                        <option value="5">办理</option>
                        <option value="6">反馈</option>
                    </select>
                </td>
                <td>
                    按类别筛选：
                    <select class="category-filter">
                        <option value="0">选择类别</option>
                        <option value="1">人大</option>
                        <option value="2">政协</option>
                        <option value="3">综合</option>
                    </select>
                </td>
            </tr>
        </table>
    </div>

</div>

<script>
var page = 0;
var orderby = 'staff_id';
var order = true;
var where = null;
var totalPage = 0;
$(document).ready(function () {
    getStaffList();
    $('.page-change').click(function () {
        if ('prev' == $(this).attr('id') && page > 0) {
            page--;
            getStaffList();
        }
        if ('next' == $(this).attr('id') && page < totalPage - 1) {
            page++;
            getStaffList();
        }
    });
    $('.search-button').click(function () {
        var name = $('.search-input').val();
        if (name) {
            page = 0;
            where = {full_name: name};
            getStaffList();
        }
    });
    $('.step-filter').change(function () {
        var _ = $(this);
        var step = _.get(0).value;
        if (step > 0) {
            page = 0;
            where = {steps: step};
            getStaffList();
        } else {
            page = 0;
            where = null;
            getStaffList();
        }
    });
    $('.category-filter').change(function () {
        var _ = $(this);
        var category = _.get(0).value;
        if (category > 0) {
            page = 0;
            if (!where)where = {category: category};
            else where.category = category;
            getStaffList();
        } else {
            page = 0;
            if (where)delete where.category;
            getStaffList();
        }
    });
    $('.super-unit').change(function () {
        var _ = $(this);
        var id = _.val();
        page = 0;
        if (0 != id) {
            if (null != where)where['unit'] = id;
            else where = {unit: id};
            ajaxPost('getSubUnit', {id: id}, function (data) {
                var backValue = backHandle(data);
                var subSelect = '<select  class="unit-filter" ><option value="0">请选择单位</option>';
                if (!backValue) {
                    console.log('no sub');
                    getStaffList();
                } else {
                    console.log('has sub');
                    $.each(backValue, function (k, v) {
                        subSelect += '<option value="' + v.id + '">' + v.name + '</option>';
                    });
                    subSelect += '</select>';
                    _.next('.unit-filter').remove();
                    _.after(subSelect);
                }

            });
        } else {
            if (null != where)delete(where.unit);
//                    console.log('a ???');
            getStaffList();
        }

    });
    $('.order').click(function(){
        orderby=$(this).data('orderby');
        order=!order;
        getStaffList();
    });
});
$(document).on('change', '.step-checkbox', function () {
    var _ = $(this);
    var thisValue = _.val();
    var checked = _.prop('checked');
    var parentTr = _.parents('.list-row');
    var staffId = parentTr.attr('id').slice('3');
    var mySteps = '';
    parentTr.find('.step-checkbox').each(function (k, v) {
        if ($(v).prop('checked'))mySteps += v.value;
    });
//            mylog(mySteps);
//    if (1 != thisValue || 1 == $('#loc' + staffId).val()) {
//        altTable('staff', 'steps', mySteps, 'staff_id', staffId, function (data) {
//            $('#cat' + staffId).empty();
//            showToast('修改完成');
//        });
//    } else if (checked) {
        var groupUnitSelecter = '<select class="group-unit-filter">' +
            '<option value="0">选择分组</option>' +
            '<option value="1group">人大-按代表团</opion>' +
            '<option value="1unit">人大-按区域</opion>' +
            '<option value="2group">政协-按界别</opion>' +
            '<option value="2unit">政协-按委组</opion>' +
            '</select>';
        $('#cat' + staffId).append(groupUnitSelecter);
        $('#cat' + staffId).attr('data-steps', mySteps);
//    }
});
$(document).on('change', '.group-unit-filter', function () {
    var _ = $(this);
    var value = _.val();
    if (0 != value) {
        var category = value.slice(0, 1);
        var name = value.slice(1);
        ajaxPost('userGroupUnit', {category: category, name: name}, function (data) {
            var backValue = backHandle(data);
            var subSelect = '<select data-category="' + category + '" data-name="' + name + '" class="group-unit-select" ><option value="0">请选择</option>';
            $.each(backValue, function (k, v) {
                subSelect += '<option value="' + v.id + '">' + v.name + '</option>';
            });
            subSelect += '</select>';
            _.next('.group-unit-select').remove();
            _.after(subSelect);
        });
    }


});
$(document).on('change', '.group-unit-select', function () {

    var _ = $(this);
    var staffId = _.parent().attr('id').slice(3);
    var steps = _.parent().data('steps');
    var value = _.val();
    var category = _.data('category')
    var name = _.data('name');
    if (0 != value) {
        var admin = '{"user_' + name + '":' + value + '}';
        altTableBatch('staff', {
            category: category,
            steps: steps,
            user_admin: admin
        }, 'staff_id', staffId, function (data) {
            showToast('修改完成');
        });
    }
});
$(document).on('click', '.delete-staff', function () {
    if (confirm('警告：此操作可能导致不可恢复的严重系统错误，确定删除？')) {
        var id=$(this).attr('id').slice(3);
        deleteRecord('staff',{staff_id:id},function(data){
            getStaffList();
        });
//        console.log('ok');
    }
});
$(document).on('change', '.unit-filter', function () {
    page = 0;
    var _ = $(this);
    var value = _.val();
    if (0 != value) {
        if (null != where)where.unit = value;
        else where = {unit: value};
    } else {
        if (null != where)delete(where.unit);
    }
    getStaffList();
});

function getStaffList() {
//            var cateName=['属性选择','人大','政协','综合'];
    var orderStr = order ? 'asc' : 'desc';
    var whereValue = where || null;
    ajaxPost('reflashStaffList', {orderby: orderby, order: orderStr, page: page, where: whereValue}, function (data) {
        var backInf = backHandle(data);
//                console.log(backInf.page);
        $('.list-row').remove();
        $.each(backInf.list, function (k, v) {
            var stepStr = '' + v.steps;
            var unitStepStr = '' + v.unit_steps;
            var source = v.out_id ? '党政信息网' : '系统';
            var content = '<tr class="list-row" id="row' + v.staff_id + '">' +
                '<td>' + v.staff_name + '</td>' +
                '<td>' + v.full_name + '</td>' +
                '<td>' + v.unit_name + '</td>' +
                '<td>' + source + '</td>';
            for (var i = 1; i < 7; i++) {
                var enabled = (!v.out_id || unitStepStr.match('' + i)) ? '' : 'disabled="true"';
                var check = stepStr.match('' + i) ? 'checked' : '';
                content += '<td><input class="step-checkbox" type="checkbox" value="' + i + '" ' + check + ' ' + enabled + '></td>'
            }
            content += '<td id="cat' + v.staff_id + '"></td>';
            var deleteButton = v.out_id ? '' : '<button class="delete-staff" id="del' + v.staff_id + '">删除</button>';
            var localStaff = v.out_id ? '0' : '1';
            content += '<td>' + deleteButton + '<input type="hidden" id="loc' + v.staff_id + '" value="' + localStaff + '"></td></tr>';
            $('.unit-table-foot').before(content);
        });
        totalPage = backInf.page;
        $('.page-total').text(totalPage);
        $('.page-now').text(page + 1);
    });
}
function reflashInf() {

}
//        function pageChange()
</script>