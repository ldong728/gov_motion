<?php global $currentMotionTemp,$currentMotionTempValueList,$id,$step;
$motionTemp=isset($currentMotionTemp)?$currentMotionTemp : array();
$currentValueList=isset($currentMotionTempValueList)?$currentMotionTempValueList : array();
$id=$_GET['id'];

?>

<div id="core" style="height: 658px;">
    <div class="block">
        <div class="head" style="width: 98%;"><span>模板属性</span></div>
        <div class="main">
            <table class="table sheet">
                <tr class="h">
                    <td>属性名称</td>
                    <td>属性可选项</td>
                    <td>属性默认值</td>
                    <td>所属流程</td>
                    <td>是否隐藏</td>
                    <td>操作</td>
                </tr>
                <?php foreach($currentValueList as $row):?>
                <tr>
                    <td><?php echo $row['attr_name']?></td>
                    <td><?php echo $row['option']?></td>
                    <td><?php echo $row['default']?></td>
                    <td id="<?php echo $row['motion_attr_template_id']?>" data-col="step" data-index="motion_attr_template_id" data-tbl="motion_attr_template">
                        <select class="select">
                            <option value="0">所属流程</option>
                            <?php foreach($step as $stepRow):?>
                            <option value="<?php echo $stepRow['step_id']?>" <?php echo $stepRow['step_id']==$row['step']? 'selected="selected"':''?>><?php echo $stepRow['step_name']?></option>
                            <?php endforeach?>
                        </select>
                    </td>
                    <td><?php echo $row['hidden']?></td>
                    <td><button class="button">操作</button></td>
                </tr>
                <?php endforeach?>
                <tr>
                    <td colspan="6">
                        <button class="button add-attr" >添加属性</button>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <script>
        var templateId=<?php echo $id?>;
        $('.add-attr').click(function(){
           addRecord('motion_attr_template',{motion_template:templateId,attr_name:"新增属性",step:0},'ignore',function(){
               location.reload(true);
           })
        });
    </script>
</div>