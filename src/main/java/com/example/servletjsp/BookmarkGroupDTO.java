package com.example.servletjsp;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor

public class BookmarkGroupDTO {
    private int id;
    private String bookmarkName;
    private int orderNo;
    private String registeredDttm;
    private String updatedDttm;
}
