package Borala.app.demo.Controller;

import Borala.app.demo.DTO.SubscriptionDTO;
import Borala.app.demo.Model.Event;
import Borala.app.demo.Model.Subscription;
import Borala.app.demo.Service.EventService;
import Borala.app.demo.Service.SubscriptionService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/subscriptions")
public class SubscriptionController {

    private final SubscriptionService subscriptionService;
    private final EventService eventService;

    public SubscriptionController(SubscriptionService subscriptionService, EventService eventService) {
        this.subscriptionService = subscriptionService;
        this.eventService = eventService;
    }

    @PostMapping
    public ResponseEntity<Subscription> createSubscription(@RequestBody SubscriptionDTO dto) {
        Optional<Event> optionalEvent = eventService.getEventById(dto.getEventId());

        if (optionalEvent.isEmpty()) {
            return ResponseEntity.badRequest().build();
        }

        Subscription subscription = new Subscription();
        subscription.setName(dto.getName());
        subscription.setEmail(dto.getEmail());
        subscription.setPhone(dto.getPhone());
        subscription.setEvent(optionalEvent.get());

        Subscription saved = subscriptionService.save(subscription);
        return ResponseEntity.ok(saved);
    }
}
