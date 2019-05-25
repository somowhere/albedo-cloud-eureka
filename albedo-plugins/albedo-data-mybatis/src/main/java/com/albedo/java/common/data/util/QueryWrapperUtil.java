package com.albedo.java.common.data.util;

import com.albedo.java.common.core.util.ClassUtil;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.QueryUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.Order;
import com.albedo.java.common.core.vo.QueryCondition;
import com.albedo.java.common.persistence.SpecificationDetail;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.google.common.collect.Lists;

import java.util.Collection;
import java.util.List;

/**
 * Created by somewhere on 2018/3/8.
 */
public class QueryWrapperUtil {

    private static Collection handlerQueryConditionCollectionValue(QueryCondition queryCondition){
        Collection col = null;
        if (queryCondition.getValue() instanceof String) {
            String val = String.valueOf(queryCondition.getValue());
            col = val.contains(",") ? Lists.newArrayList(val.split(","))
                : Lists.newArrayList(val);
        }
        if (queryCondition.getValue() instanceof Collection) {
            col = (Collection) queryCondition.getValue();
        }
        return col;
    }
    private static String handlerQueryConditionLikeValue(QueryCondition queryCondition){
        String val = (String) queryCondition.getValue();
        return  !val.startsWith("%") && !val.toString().endsWith("%")
            ? StringUtil.toAppendStr("%", val, "%") : val;
    }

    public static String getFieldRealColumnName(Class<?> targetPersistentClass, String fieldPropery) {

        if (targetPersistentClass != null && StringUtil.isNotEmpty(fieldPropery)) {
            TableField column = ClassUtil.findAnnotation(targetPersistentClass, fieldPropery, TableField.class);
            if (column != null){
                fieldPropery = column.value();
            }else{
                TableId columnId = ClassUtil.findAnnotation(targetPersistentClass, fieldPropery, TableId.class);
                if(columnId!=null) {
                    fieldPropery = columnId.value();
                }
            }
        }

        return fieldPropery;
    }


    public static <T> QueryWrapper<T> convertSpecificationDetail(SpecificationDetail<T> specificationDetail){
        QueryWrapper entityWrapper = new QueryWrapper();
        List<QueryCondition> andQueryConditions = specificationDetail.getAndQueryConditions();
        if(CollUtil.isNotEmpty(specificationDetail.getAndQueryConditions())){
            for(QueryCondition queryCondition : andQueryConditions){
                Object queryValue = QueryUtil.getQueryValue(queryCondition, null);
                String fieldName = QueryWrapperUtil.getFieldRealColumnName(specificationDetail.getPersistentClass(), queryCondition.getFieldName());
                if(specificationDetail.isRelationQuery()) {
                    fieldName = specificationDetail.getClassNameProfix() + fieldName;
                }
                switch (queryCondition.getOperate()) {
                    case notIn:
                        entityWrapper.notIn(fieldName, handlerQueryConditionCollectionValue(queryCondition));
                        break;
                    case in:
                        entityWrapper.in(fieldName, handlerQueryConditionCollectionValue(queryCondition));
                        break;
                    case like:
                        entityWrapper.like(fieldName, handlerQueryConditionLikeValue(queryCondition));
                        break;
                    case notLike:
                        entityWrapper.notLike(fieldName, handlerQueryConditionLikeValue(queryCondition));
                        break;
                    case between:
                        entityWrapper.between(fieldName
                            , queryValue
                            , QueryUtil.getQueryValue(queryCondition, queryCondition.getEndValue()));
                        break;
                    case isNull:
                        entityWrapper.isNull(fieldName);
                        break;
                    case isNotNull:
                        entityWrapper.isNotNull(fieldName);
                        break;
                        default:
                            entityWrapper.apply(StringUtil.toAppendStr(
                                fieldName," ",
                                queryCondition.getOperate().getOperator(), " {0} "
                                ), queryValue);
                            break;

                }
            }
        }
        List<Order> orders = specificationDetail.getOrders();
        if(CollUtil.isNotEmpty(orders)){
            for (Order order : orders){
                String fieldName = QueryWrapperUtil.getFieldRealColumnName(specificationDetail.getPersistentClass(), order.getProperty());
                if(specificationDetail.isRelationQuery()) {
                    fieldName = specificationDetail.getClassNameProfix() + fieldName;
                }
                entityWrapper.orderBy(true, Order.Direction.asc.equals(order.getDirection()), fieldName);
            }
        }
        return entityWrapper;
    }

    public static <T> QueryWrapper<T> create() {
        return new QueryWrapper();
    }
}
