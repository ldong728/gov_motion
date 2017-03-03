<?php global $getStr,$page,$num,$count,$orderIndex,$order,$list,$step;
?>

<div id="core" style="height: 658px;">
    <div class="block">
        <div class="head" style="width: 98%;"><span>选项编辑</span></div>
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
                <?php foreach($list as $row):?>
                    <tr>
                        <td class="ipt-toggle" id="<?php htmlout( $row['attr_template_id'])?>" data-col="attr_name" data-index="attr_template_id" data-tbl="attr_template"><?php htmlout( $row['attr_name'])?></td>
                        <td class="ipt-toggle" id="<?php htmlout( $row['attr_template_id'])?>" data-col="option" data-index="attr_template_id" data-tbl="attr_template"><?php echo json_encode($row['option'],JSON_UNESCAPED_UNICODE)?></td>
                        <td  <?php echo is_array($row['option'])? '':'class="ipt-toggle"'?> id="<?php htmlout( $row['attr_template_id'])?>" data-col="default_value" data-index="attr_template_id" data-tbl="attr_template">
                            <?php if(is_array($row['option'])):?>

                                <select class="select">
                                    <option value="">选择默认</option>
                                    <?php foreach($row['option'] as $cRow):?>
                                        <option value="<?php htmlout($cRow)?>" <?php echo $cRow==$row['default_value']?'selected="selected"':''?>><?php htmlout( $cRow)?></option>
                                    <?php endforeach ?>
                                </select>
                            <?php else:?>

                            <?php endif?>
                        </td>
                        <td id="<?php htmlout( $row['attr_template_id'])?>" data-col="step" data-index="attr_template_id" data-tbl="attr_template">
                            <select class="select">
                                <option value="0">所属流程</option>
                                <?php foreach($step as $stepRow):?>
                                    <option value="<?php htmlout( $stepRow['step_id'])?>" <?php htmlout( $stepRow['step_id']==$row['step']? 'selected="selected"':'')?>><?php htmlout( $stepRow['step_name'])?></option>
                                <?php endforeach?>
                            </select>
                        </td>
                        <td><?php htmlout( $row['hidden'])?></td>
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
        $('.add-attr').click(function(){
            addRecord('attr_template',{attr_name:"新增属性",step:0},'ignore',function(){
                location.reload(true);
            })
        });
    </script>
</div>