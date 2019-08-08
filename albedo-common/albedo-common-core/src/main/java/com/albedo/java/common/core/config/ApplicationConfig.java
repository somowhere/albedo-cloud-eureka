package com.albedo.java.common.core.config;

import com.albedo.java.common.core.util.StringUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import java.io.InputStream;

/**
 * 系统配置类
 *
 * @author somowhere version 2014-1-20 下午4:06:33
 */
@Slf4j
public class ApplicationConfig {

    private static java.util.Properties props = null;

    static {
        try {
            reload(null);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 将构造函数私有化，不能new实例
     */
    private ApplicationConfig() {

    }

    /**
     * 获取配置信息的静态方法。
     *
     * @param name - 要获取的配置信息的名称
     * @return - 配置信息。如果不存在，返回null
     */
    public static String get(String name) {
        if (props == null) {
            return null;
        }
        try {
            if (props.getProperty(name) != null) {
                return props.getProperty(name).trim();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    /**
     * 重新装载配置信息。
     *
     * @throws Exception
     */
    public static void reload(String path) throws Exception {
        if (props == null) {
            props = new java.util.Properties();
        }
        PathMatchingResourcePatternResolver resourceLoader = new PathMatchingResourcePatternResolver();
        InputStream is = resourceLoader.getResources(StringUtil.isEmpty(path) ? "/albedo.properties" : path)[0].getInputStream();
        // in
        // the
        // classpath
        props.load(is);
        // dumpSystemConfig();
    }

}
