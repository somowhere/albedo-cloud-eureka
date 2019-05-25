package com.albedo.java.common.core.util;

import cn.hutool.core.annotation.AnnotationUtil;
import cn.hutool.core.bean.BeanUtil;
import com.albedo.java.common.core.annotation.BeanField;
import lombok.experimental.UtilityClass;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.BeansException;
import org.springframework.beans.FatalBeanException;
import org.springframework.core.annotation.AnnotatedElementUtils;
import org.springframework.util.Assert;
import org.springframework.util.ClassUtils;

import java.beans.PropertyDescriptor;
import java.lang.reflect.AnnotatedElement;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.Arrays;
import java.util.List;

/**
 * bean copy 工具类
 *
 * @author somewhere
 */
@Slf4j
@UtilityClass
public class BeanVoUtil extends BeanUtils {

    public static void copyProperties(Object source, Object target, boolean ignoreNull, String... ignoreProperties) {
        Assert.notNull(source, "Source must not be null");
        Assert.notNull(target, "Target must not be null");
        Class<?> actualEditable = target.getClass();


        PropertyDescriptor[] targetPds = getPropertyDescriptors(actualEditable);
        List<String> ignoreList = ignoreProperties != null ? Arrays.asList(ignoreProperties) : null;
        PropertyDescriptor[] var7 = targetPds;
        int var8 = targetPds.length;

        for (int var9 = 0; var9 < var8; ++var9) {
            PropertyDescriptor targetPd = var7[var9];
            Method writeMethod = targetPd.getWriteMethod();
            if (writeMethod != null && (ignoreList == null || !ignoreList.contains(targetPd.getName()))) {
            	BeanField annotation = ClassUtil.findAnnotation(source.getClass(),targetPd.getName(),  BeanField.class);
                if(annotation!=null && annotation.ingore()){
                    continue;
                }
                BeanField writeAnnotation = ClassUtil.findAnnotation(target.getClass(),targetPd.getName(), BeanField.class);
                if(writeAnnotation!=null && writeAnnotation.ingore()){
                    continue;
                }
                Object value = null;
                if(writeAnnotation!=null && StringUtil.isNotEmpty(writeAnnotation.writeProperty())){
                    value = BeanUtil.getFieldValue(source, writeAnnotation.writeProperty());
                }else{
                    PropertyDescriptor sourcePd = getPropertyDescriptor(source.getClass(), targetPd.getName());
                    if (sourcePd != null) {
                        Method readMethod = sourcePd.getReadMethod();
                        if (readMethod != null && ClassUtils.isAssignable(writeMethod.getParameterTypes()[0], readMethod.getReturnType())) {
                            if (!Modifier.isPublic(readMethod.getDeclaringClass().getModifiers())) {
                                readMethod.setAccessible(true);
                            }
                            try {
                                value = readMethod.invoke(source);
                            } catch (Throwable var15) {
                                throw new FatalBeanException("Could not copy property '" + targetPd.getName() + "' from source to target", var15);
                            }
                            if (!Modifier.isPublic(writeMethod.getDeclaringClass().getModifiers())) {
                                writeMethod.setAccessible(true);
                            }
                        }
                    }
                }
                try {
                    if (ignoreNull && value!=null || !ignoreNull) {
                        writeMethod.invoke(target, value);
                    }
                } catch (Throwable var15) {
                    throw new FatalBeanException("Could not copy property '" + targetPd.getName() + "' from source to target", var15);
                }

            }
        }

    }


    public static <T> T copyPropertiesByClass(Object source, Class<T> requiredType){
        T target = null;
        try {
            target = requiredType.newInstance();
        } catch (Exception e) {
            log.error("{}",e);
        }
		try {
			copyProperties(source, target, true);
		} catch (Exception e) {
			log.error("{}",e);
		}
		return target;
    }

}
