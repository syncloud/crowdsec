package pkg

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
