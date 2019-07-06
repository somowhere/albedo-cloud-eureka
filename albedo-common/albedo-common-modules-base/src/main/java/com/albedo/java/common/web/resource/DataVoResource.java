package com.albedo.java.common.web.resource;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.ResponseBuilder;
import com.albedo.java.common.core.vo.DataEntityVo;
import com.albedo.java.common.persistence.service.DataVoService;
import com.codahale.metrics.annotation.Timed;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

/**
 * 基础控制器支持类 copyright 2014 albedo all right reserved author MrLi created on 2014年10月15日 下午4:04:00
 */
public class DataVoResource<Service extends DataVoService, V extends DataEntityVo>
        extends BaseResource {

    protected final Service service;

    public DataVoResource(Service service){
        this.service = service;
    }

    /**
     * @param id
     * @return
     */
    @GetMapping(CommonConstants.URL_ID_REGEX)
    @Timed
    public ResponseEntity<V> get(@PathVariable String id) {
        log.debug("REST request to get Entity : {}", id);
        return (ResponseEntity<V>) ResponseBuilder.wrapOrNotFound(Optional.ofNullable(service.findOneVo(id)));
    }

    @ResponseBody
    @GetMapping(value = "checkByProperty")
    public boolean checkByProperty(V entityForm) {
        return service.doCheckByProperty(entityForm);
    }

    @ResponseBody
    @GetMapping(value = "checkByPK")
    public boolean checkByPK(V entityForm) {
        return service.doCheckByPK(entityForm);
    }


}
