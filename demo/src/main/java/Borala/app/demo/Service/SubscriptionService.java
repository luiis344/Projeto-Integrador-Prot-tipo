package Borala.app.demo.Service;

import Borala.app.demo.Model.Subscription;
import Borala.app.demo.Repository.SubscriptionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class SubscriptionService {

    private final SubscriptionRepository repository;

    @Autowired
    public SubscriptionService(SubscriptionRepository repository) {
        this.repository = repository;
    }

    // Criar nova inscrição
    public Subscription save(Subscription subscription) {
        return repository.save(subscription);
    }

    // Buscar todas as inscrições
    public List<Subscription> getAll() {
        return repository.findAll();
    }

    // Buscar inscrição por ID
    public Optional<Subscription> getById(Long id) {
        return repository.findById(id);
    }

    // Deletar inscrição por ID
    public void deleteById(Long id) {
        repository.deleteById(id);
    }
}
