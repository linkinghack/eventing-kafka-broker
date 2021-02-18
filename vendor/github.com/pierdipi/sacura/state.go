package sacura

import (
	"github.com/google/go-cmp/cmp"
	"k8s.io/apimachinery/pkg/util/sets"
)

type StateManager struct {
	received sets.String
	sent     sets.String
}

func NewStateManager() *StateManager {
	return &StateManager{
		received: sets.NewString(),
		sent:     sets.NewString(),
	}
}

func (s *StateManager) ReadSent(sent <-chan string) <-chan struct{} {
	sg := make(chan struct{})
	go func(set *StateManager) {
		for id := range sent {
			s.sent.Insert(id)
		}
		sg <- struct{}{}
	}(s)
	return sg
}

func (s *StateManager) ReadReceived(received <-chan string) <-chan struct{} {
	sg := make(chan struct{})
	go func(set *StateManager) {
		for id := range received {
			s.received.Insert(id)
		}
		sg <- struct{}{}
	}(s)
	return sg
}

func (s *StateManager) Diff() string {
	return cmp.Diff(s.received.List(), s.sent.List())
}
