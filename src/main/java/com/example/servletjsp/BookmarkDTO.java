package com.example.servletjsp;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor

public class BookmarkDTO {
    private int id;
    private int groupId;
    private String mgrNo;
    private String registeredDttm;
}
