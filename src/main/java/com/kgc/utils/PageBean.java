package com.kgc.utils;

import java.util.List;

/**
 * 自定义分页类
 */
/*@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter*/
public class PageBean<T>{
    //当前页
    private Integer pageNum;
    //总页数
    private Integer pages;
    //总的数据条数
    private Long total;
    //上一页
    private Integer prePage;
    //下一页
    private Integer nexPage;
    //结果集
    private List<T> list;

    public Integer getPageNum() {
        return pageNum;
    }

    public void setPageNum(Integer pageNum) {
        this.pageNum = pageNum;
    }

    public Integer getPages() {
        return pages;
    }

    public void setPages(Integer pages) {
        this.pages = pages;
    }
    public Long getTotal() {
        return total;
    }

    public void setTotal(Long total) {
        this.total = total;
    }

    public Integer getPrePage() {
        return prePage;
    }

    public void setPrePage(Integer prePage) {
        this.prePage = prePage;
    }

    public Integer getNexPage() {
        return nexPage;
    }

    public void setNexPage(Integer nexPage) {
        this.nexPage = nexPage;
    }

    public List<T> getList() {
        return list;
    }

    public void setList(List<T> list) {
        this.list = list;
    }
}
