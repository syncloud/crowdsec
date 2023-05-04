package pkg

import (
 cp "github.com/otiai10/copy"
)

const (
	App = "crowdsec"
)

type Installer struct {
}

func New() *Installer {
	return &Installer{}
}

func (i *Installer) Install() error {
	err := CreateUser(App)
	if err != nil {
		return err
	}
 err = cp.Copy("/snap/crowdsec/current/config", "/var/snap/crowdsec/current/config")
 if err != nil {
		return err
	}
	return nil
}

func (i *Installer) Configure() error {
	return nil
}

func (i *Installer) PreRefresh() error {
	return nil
}

func (i *Installer) PostRefresh() error {
	return nil
}
