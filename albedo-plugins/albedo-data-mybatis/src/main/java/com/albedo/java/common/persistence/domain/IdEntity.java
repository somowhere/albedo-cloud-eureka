package com.albedo.java.common.persistence.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;

import java.io.Serializable;
import java.util.Objects;


/**
 * @author somewhere
 */
public class IdEntity<T extends BaseEntity> extends DataEntity<T> {

    private static final long serialVersionUID = 1L;
    @TableId(value = GeneralEntity.F_SQL_ID, type = IdType.UUID)
    protected String id;

    public IdEntity() {
        super();
    }

	@Override
	protected Serializable pkVal() {
		return this.getId();
	}
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        IdEntity idEntity = (IdEntity) o;
        if (idEntity.getId() == null || getId() == null) {
            return false;
        }
        return Objects.equals(getId(), idEntity.getId());
    }
    @Override
    public int hashCode() {
        return Objects.hashCode(getId());
    }
}
