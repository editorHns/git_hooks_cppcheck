# Git hooks + cppcheck

Учебный проект для задания «Система контроля версий. Автоматизация действий».

## Что реализовано

### pre-commit

Перед созданием commit выполняется hook:

```text
.git/hooks/pre-commit
```

Он выводит краткую информацию о последних трёх изменениях:

```bash
git log -3 --oneline --decorate
```

### post-commit

После создания commit выполняется:

```text
.git/hooks/post-commit
```

Hook запускает статический анализатор `cppcheck`:

```bash
cppcheck --enable=warning,style,performance,portability --error-exitcode=1 src
```

Если cppcheck обнаруживает ошибки, hook возвращает ненулевой код.

## Установка

### 1. Создать Git-репозиторий

В корне проекта:

```bash
git init
```

### 2. Установить hooks

```bash
bash scripts/install_hooks.sh
```

### 3. Проверить

```bash
ls -la .git/hooks
```

Должны появиться:

```text
pre-commit
post-commit
```

## Установка cppcheck

Ubuntu / WSL:

```bash
sudo apt update
sudo apt install cppcheck
```

Проверка:

```bash
cppcheck --version
```

Windows: можно установить cppcheck отдельно и убедиться, что команда `cppcheck`
доступна из Git Bash/терминала.

## Демонстрация

Добавить файлы:

```bash
git add .
```

Создать commit:

```bash
git commit -m "Initial commit"
```

Во время commit сначала сработает `pre-commit` и покажет:

```text
=== PRE-COMMIT ===
Последние три изменения:
...
```

После создания commit сработает `post-commit`:

```text
=== POST-COMMIT ===
Запуск статического анализа cppcheck...
cppcheck: ошибок не обнаружено.
```

## Проверка последних трёх изменений

После нескольких commit можно вручную выполнить:

```bash
git log -3 --oneline --decorate
```

## Важный момент

Содержимое `.git/hooks` не хранится в обычном Git commit. Поэтому в репозитории
хранятся исходники hooks в `scripts/`, а `scripts/install_hooks.sh` копирует их
в `.git/hooks`.

Это позволяет другому человеку после клонирования проекта установить hooks
одной командой.
