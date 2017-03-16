<?php global $attrList, $totalAttrList, $id,$step,$motionTempName,$valueTypes,$targetList;

?>

<div id="core" style="height: 658px;">
    <div class="block">
        <div class="head" style="width: 98%;"><span><?php htmlout($motionTempName)?></span></div>
        <div class="main">
            <table class="table sheet">
                <tr class="h">
                    <td>属性名称</td>
                    <!--                    <td>属性可选项</td>-->
                    <td>属性默认值</td>
                    <td>所属流程</td>
                    <td>是否隐藏</td>
                    <td>值类型</td>
                    <td>目标表</td>
                    <td>附件</td>
                    <td>排序</td>
                    <td>多值</td>
<!--                    <td>操作</td>-->

                </tr>
                <?php foreach ($attrList as $row): ?>
                    <tr>
                        <td><?php htmlout($row['attr_name']) ?></td>
                        <!--                    <td class="ipt-toggle" id="-->
                        <?php //htmlout( $row['motion_attr_template_id'])?><!--" data-col="option" data-index="motion_attr_template_id" data-tbl="motion_attr_template">-->
                        <?php //echo json_encode($row['option'],JSON_UNESCAPED_UNICODE)?><!--</td>-->
                        <td  <?php echo is_array($row['option']) ? '' : 'class="ipt-toggle"' ?>
                            id="<?php htmlout($row['motion_attr_id']) ?>" data-col="default_value"
                            data-index="motion_attr_id" data-tbl="motion_attr">
                            <?php if (is_array($row['option'])): ?>

                                <select class="select">
                                    <option value="">选择默认</option>
                                    <?php foreach ($row['option'] as $cRow): ?>
                                        <option
                                            value="<?php htmlout($cRow) ?>" <?php echo $cRow == $row['default_value'] ? 'selected="selected"' : '' ?>><?php htmlout($cRow) ?></option>
                                    <?php endforeach ?>
                                </select>
                            <?php else: ?>

                            <?php endif ?>
                        </td>
                        <td id="<?php htmlout($row['motion_attr_id']) ?>" data-col="step"
                            data-index="motion_attr_id" data-tbl="motion_attr">
                            <select class="select">
                                <option value="0">所属流程</option>
                                <?php foreach ($step as $stepRow): ?>
                                    <option
                                        value="<?php htmlout($stepRow['step_id']) ?>" <?php htmlout($stepRow['step_id'] == $row['step'] ? 'selected="selected"' : '') ?>><?php htmlout($stepRow['step_name']) ?></option>
                                <?php endforeach ?>
                            </select>
                        </td>
                        <td><?php htmlout($row['hidden']) ?></td>
                        <td  id="<?php htmlout($row['motion_attr_id']) ?>" data-col="value_type"
                             data-index="motion_attr_id" data-tbl="motion_attr">
                            <select class="select value-type">
                                <?php foreach($valueTypes as $vRow):?>
                                <option value="<?php echo $vRow?>" <?php echo $vRow==$row['value_type']?'selected="selected"':''?>><?php echo $vRow?></option>
                                <?php endforeach ?>
                            </select>

                        </td>
                        <td class="ipt-toggle" id="<?php htmlout($row['motion_attr_id']) ?>" data-col="target"
                            data-index="motion_attr_id" data-tbl="motion_attr">
                            <select class="select">
                                <option value="">无</option>
                                <?php foreach($targetList as $tRow):?>
                                <option value="<?php echo $tRow?>" <?php echo $tRow==$row['target']? 'selected="selected"':''?>><?php echo $tRow?></option>
                                <?php endforeach ?>
                            </select>
                        </td>
                        <td class="ipt-toggle" id="<?php htmlout($row['motion_attr_id']) ?>" data-col="has_attachment"
                            data-index="motion_attr_id" data-tbl="motion_attr">
                            <?php echo $row['has_attachment']?>
                        </td>
                        <td class="ipt-toggle" id="<?php htmlout($row['motion_attr_id']) ?>" data-col="value_sort"
                            data-index="motion_attr_id" data-tbl="motion_attr">
                            <?php echo $row['value_sort']?>
                        </td>
                        <td class="ipt-toggle" id="<?php htmlout($row['motion_attr_id']) ?>" data-col="multiple"
                            data-index="motion_attr_id" data-tbl="motion_attr">
                            <?php echo $row['multiple']?>
                        </td>
<!--                        <td >-->
<!--                            <button class="button">操作</button>-->
<!--                            <button class="button del-attr" id="del--><?php //echo $row['motion_attr_id']?><!--">删除</button>-->
<!--                        </td>-->
                    </tr>
                <?php endforeach ?>
                <tr>
                    <td colspan="6">
                        <select class="candidate">
                            <option value="-1">侯选属性</option>
                            <?php foreach ($totalAttrList as $row): ?>
                                <option
                                    value="<?php echo $row['attr_template_id'] ?>"><?php echo $row['attr_name'] ?></option>
                            <?php endforeach ?>
                        </select>
                        <button class="button add-attr">添加属性</button>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <script>
        var templateId =<?php htmlout( $id)?>;
        $('.add-attr').click(function () {
            var attrTempId = $('.candidate').val()
            if (attrTempId > -1) {
                addRecord('motion_attr', {
                        motion_template: templateId,
                        attr_template: attrTempId,
                        default_value: ''
                    }, 'ignore', function () {
                        location.reload(true);
                    }
                )
            }else{
                showToast("请先选择一个属性")
            }
        });
        $('.del-attr').click(function(){
            var id=$(this).attr('id').slice(3);
            deleteRecord('motion_attr',{motion_attr_id:id},function(){
                location.reload(true);
            })
        })
    </script>
</div>