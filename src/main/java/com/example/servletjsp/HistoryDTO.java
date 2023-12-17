package com.example.servletjsp;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor

public class HistoryDTO {
    private int id;
    private String lat;
    private String lnt;
    private String searchDttm;
}
