package Borala.app.demo.Service;

import Borala.app.demo.Model.Event;
import Borala.app.demo.Repository.EventRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class EventService {

    @Autowired
    private final EventRepository eventRepository;

    public EventService(EventRepository eventRepository) {
        this.eventRepository = eventRepository;
    }

    // CREATE
    public Event salvar(Event event){
        return eventRepository.save(event);
    }

    // UPDATE
    public Event atualizar(Event event){
        return eventRepository.save(event);
    }

    // READ ALL
    public List<Event> getAllEvents() {
        return eventRepository.findAll();
    }

    // READ BY ID
    public Optional<Event> getEventById(Long id) {
        return eventRepository.findById(id);
    }

    // DELETE
    public void deletar(Long id){
        eventRepository.deleteById(id);
    }
}
