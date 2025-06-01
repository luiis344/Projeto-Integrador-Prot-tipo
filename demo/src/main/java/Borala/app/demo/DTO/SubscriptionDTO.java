package Borala.app.demo.DTO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SubscriptionDTO {
    private String name;
    private String email;
    private String phone;
    private Long eventId;
}
