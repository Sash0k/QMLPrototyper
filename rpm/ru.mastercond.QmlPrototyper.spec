Name:       ru.mastercond.QmlPrototyper

Summary:    Приложение для создания кода интерфейса на QML прямо на телефоне или планшете под управлением ОС Аврора
Version:    0.4
Release:    1
Group:      Qt/Qt
License:    BSD-3-Clause
URL:        https://software.mastercond.ru
Source0:    %{name}-%{version}.tar.bz2

Requires:   sailfishsilica-qt5 >= 0.10.9
BuildRequires:  pkgconfig(auroraapp)
BuildRequires:  pkgconfig(Qt5Core)
BuildRequires:  pkgconfig(Qt5Qml)
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  desktop-file-utils


%description
Создавайте, сохраняйте и проверяйте QML-код страниц или компонентов прямо на устройстве под управлением ОС Аврора. <br><br>Работа производится с файлами в папке Документы/QML прототипы/

%prep
%setup -q -n %{name}-%{version}

%build
%qmake5
%make_build

%install
rm -rf %{buildroot}
%qmake5_install

desktop-file-install --delete-original         --dir %{buildroot}%{_datadir}/applications                %{buildroot}%{_datadir}/applications/*.desktop

%files
%defattr(-,root,root,-)
%{_bindir}/%{name}
%defattr(644,root,root,-)
%{_datadir}/%{name}
%{_datadir}/applications/%{name}.desktop
%{_datadir}/icons/hicolor/*/apps/%{name}.png
