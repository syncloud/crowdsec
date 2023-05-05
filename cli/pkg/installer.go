package pkg

import (
	cp "github.com/otiai10/copy"
	"path"
)

const (
	App     = "crowdsec"
	AppDir  = "/snap/crowdsec/current"
	DataDir = "/var/snap/crowdsec/current"
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
	err = cp.Copy(path.Join(AppDir, "config"), path.Join(DataDir))
	if err != nil {
		return err
	}

	err = cp.Copy(path.Join(AppDir, "metabase/metabase.db"), path.Join(DataDir))
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
