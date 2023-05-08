package pkg

import (
	"fmt"
	cp "github.com/otiai10/copy"
	"os"
	"os/exec"
	"path"
)

const (
	App       = "crowdsec"
	AppDir    = "/snap/crowdsec/current"
	DataDir   = "/var/snap/crowdsec/current"
	CommonDir = "/var/snap/crowdsec/common"
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
	err = cp.Copy(path.Join(AppDir, "config"), path.Join(DataDir, "config"))
	if err != nil {
		return err
	}

	err = cp.Copy(path.Join(AppDir, "metabase/metabase.db"), path.Join(DataDir))
	if err != nil {
		return err
	}
	err = cp.Copy(path.Join(AppDir, "crowdsec/staging/var/lib/crowdsec/data"), path.Join(DataDir, "data"))
	if err != nil {
		return err
	}

	err = os.Mkdir(path.Join(CommonDir, "nginx"), 0755)
	if err != nil {
		return err
	}

	command := exec.Command("snap",
		"run",
		"crowdsec.cscli",
		"-c", path.Join(DataDir, "config/crowdsec/config.yaml"),
		"machines", "add", "-a",
	)
	output, err := command.CombinedOutput()
	if err != nil {
		return fmt.Errorf("%w: %s", err, string(output))
	}

	err = Chown(DataDir, App)
	if err != nil {
		return err
	}
	err = Chown(CommonDir, App)
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
