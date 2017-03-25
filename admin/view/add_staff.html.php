<?php global $superUnit?>

<div id="core" style="height: 658px;">
    <div class="block">
        <div class="head" style="width: 98%;"><span>新建操作员</span></div>
        <div class="main">
            <table class="table sheet unit-table">
                <tr>
                    <td class="h">id：</td>
                    <td><input type="text" class="staff-inf" data-col="staff_name" placeholder="登陆用，请用英文字母" width="250px"></td>
                    <td class="h">全名：</td>
                    <td><input type="text" class="staff-inf" data-col="full_name" placeholder="请用中文"></td>
                </tr>
                <tr>
                    <td class="h">密码：</td>
                    <td><input type="text" class="staff-inf" data-col="staff_password" placeholder="请输入密码"></td>
                    <td class="h">分类：</td>
                    <td > <select class="category-filter staff-inf" data-col="category">
                            <option value="0">选择类别</option>
                            <option value="1">人大</option>
                            <option value="2">政协</option>
                            <option value="3">综合</option>
                        </select></td>
                </tr>
                <tr>
                    <td class="h">权限：</td>
                    <td colspan="3">提交：<input class="step-checkbox" type="checkbox" value="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;登记：<input class="step-checkbox" type="checkbox" value="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;审核：<input class="step-checkbox" type="checkbox" value="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;交办：<input class="step-checkbox" type="checkbox" value="4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;办理：<input class="step-checkbox" type="checkbox" value="5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;反馈：<input class="step-checkbox" type="checkbox" value="6"></td>
                </tr>
                <tr>
                    <td class="h">单位：</td>
                    <td colspan="3"><select class="super-unit"><option value="0">选择单位</option>
                            <?php foreach($superUnit as $row):?>
                                <option value="<?php echo $row['id']?>"><?php echo $row['name']?></option>
                            <?php endforeach ?>
                        </select></td>
                </tr>
                <tr>
                    <td colspan="4"><input type="button" class="create-button" value="新建操作员"></td>
                </tr>
            </table>
    </div>

</div>

<script>
var mySteps='';
$(document).ready(function () {
//    getStaffList();
    $('.super-unit').change(function() {
        var _ = $(this);
        var id = _.val();
        var name= _.find('option:selected').text()
//        console.log(name);
        page = 0;
        if (0 != id) {
            ajaxPost('getSubUnit', {id: id}, function (data) {
                var backValue = backHandle(data);
                var subSelect = '<select  class="unit-select staff-inf" data-col="unit" >';
                if (!backValue) {
//                    console.log('no value');
                    subSelect+='<option value="'+id+'">'+name+'</option>';
                } else {
                    console.log(backValue);
                    subSelect+='<option value="0">请选择单位</option>';
                    $.each(backValue, function (k, v) {
                        subSelect += '<option value="' + v.id + '">' + v.name + '</option>';
                    });
                }
                subSelect += '</select>';
                _.next('.unit-select').remove();
                _.after(subSelect);
            });
        } else {
            if (null != where)delete(where.unit);
//                    console.log('a ???');
            getStaffList();
        }

    });
    $('.create-button').click(function(){
        var userInf={steps:mySteps}
        $('.staff-inf').each(function(k,v){
            userInf[$(v).data('col')]= v.value;
        })
        addRecord('staff',userInf,'ignore',function(data){
            window.location.reload(true);
        })
    });
});
$(document).on('change', '.step-checkbox', function () {
    mySteps='';
    var _ = $(this);
    var thisValue = _.val();
    var checked = _.prop('checked');
    var parentTr = _.parent();

    parentTr.find('.step-checkbox').each(function (k, v) {
        if ($(v).prop('checked'))mySteps += v.value;
    });
    console.log(mySteps);

});

</script>