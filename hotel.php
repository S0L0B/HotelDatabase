<?php
// ─── Conexão ───────────────────────────────────────────────────────────────
$host   = 'localhost';
$db     = 'hotel';
$user   = 'root';
$pass   = '';
$charset= 'utf8mb4';

$dsn = "mysql:host=$host;dbname=$db;charset=$charset";
try {
    $pdo = new PDO($dsn, $user, $pass, [
        PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]);
} catch (PDOException $e) {
    die("<div style='padding:2rem;color:red;font-family:monospace'>Erro de conexao: " . $e->getMessage() . "</div>");
}

// ─── Tabelas disponíveis ───────────────────────────────────────────────────
$tabelas = [
    'tipo_reserva', 'tipo_quarto', 'quarto', 'departamento_cargo',
    'cargo_funcionario', 'funcionario', 'tel_funcionario', 'endereco_funcionario',
    'cliente', 'cliente_pessoa', 'pessoa_fisica', 'pessoa_juridica',
    'tel_cliente', 'endereco_cliente', 'reserva', 'checkin',
    'checkout', 'consumo', 'hospedes', 'tel_hospede'
];

// ─── Ações CRUD ────────────────────────────────────────────────────────────
$msg = '';
$tabela_atual = isset($_GET['t']) && in_array($_GET['t'], $tabelas) ? $_GET['t'] : $tabelas[0];

// DELETE
if (isset($_GET['action']) && $_GET['action'] === 'delete' && isset($_GET['id']) && isset($_GET['pk'])) {
    $pk  = preg_replace('/[^a-z_]/', '', $_GET['pk']);
    $id  = (int)$_GET['id'];
    try {
        $pdo->prepare("DELETE FROM `$tabela_atual` WHERE `$pk` = ?")->execute([$id]);
        $msg = "<div class='msg ok'>Registro excluido com sucesso.</div>";
    } catch (PDOException $e) {
        $msg = "<div class='msg err'>Erro ao excluir: " . $e->getMessage() . "</div>";
    }
}

// INSERT / UPDATE
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['_action'])) {
    $action = $_POST['_action'];
    $pk     = preg_replace('/[^a-z_]/', '', $_POST['_pk']);
    unset($_POST['_action'], $_POST['_pk'], $_POST['_id']);

    $cols = array_keys($_POST);
    $vals = array_values($_POST);
    // transforma string vazia em NULL
    $vals = array_map(fn($v) => $v === '' ? null : $v, $vals);

    try {
        if ($action === 'insert') {
            $placeholders = implode(',', array_fill(0, count($cols), '?'));
            $colNames     = implode(',', array_map(fn($c) => "`$c`", $cols));
            $pdo->prepare("INSERT INTO `$tabela_atual` ($colNames) VALUES ($placeholders)")->execute($vals);
            $msg = "<div class='msg ok'>Registro inserido com sucesso.</div>";
        } elseif ($action === 'update') {
            $id      = (int)$_POST['_id'] ?? 0;
            // pega id do campo oculto antes de desempacotar
            $id      = (int)($_REQUEST['_id'] ?? 0);
            $setStr  = implode(',', array_map(fn($c) => "`$c` = ?", $cols));
            $vals[]  = $id;
            $pdo->prepare("UPDATE `$tabela_atual` SET $setStr WHERE `$pk` = ?")->execute($vals);
            $msg = "<div class='msg ok'>Registro atualizado com sucesso.</div>";
        }
    } catch (PDOException $e) {
        $msg = "<div class='msg err'>Erro: " . $e->getMessage() . "</div>";
    }
}

// ─── Helpers ───────────────────────────────────────────────────────────────
function getColunas(PDO $pdo, string $tabela): array {
    return $pdo->query("DESCRIBE `$tabela`")->fetchAll();
}

function getPK(PDO $pdo, string $tabela): string {
    foreach (getColunas($pdo, $tabela) as $col) {
        if ($col['Key'] === 'PRI') return $col['Field'];
    }
    return 'id';
}

function getLinhas(PDO $pdo, string $tabela): array {
    return $pdo->query("SELECT * FROM `$tabela`")->fetchAll();
}

function getLinha(PDO $pdo, string $tabela, string $pk, int $id): array {
    $st = $pdo->prepare("SELECT * FROM `$tabela` WHERE `$pk` = ?");
    $st->execute([$id]);
    return $st->fetch() ?: [];
}

$colunas = getColunas($pdo, $tabela_atual);
$pk      = getPK($pdo, $tabela_atual);
$linhas  = getLinhas($pdo, $tabela_atual);

// linha para edição
$edit_row = [];
if (isset($_GET['action']) && $_GET['action'] === 'edit' && isset($_GET['id'])) {
    $edit_row = getLinha($pdo, $tabela_atual, $pk, (int)$_GET['id']);
}

// ─── Ícones por tabela ─────────────────────────────────────────────────────
$icones = [
    'tipo_reserva'=>'🏷️','tipo_quarto'=>'🛏️','quarto'=>'🚪','departamento_cargo'=>'🏢',
    'cargo_funcionario'=>'💼','funcionario'=>'👤','tel_funcionario'=>'📞','endereco_funcionario'=>'📍',
    'cliente'=>'🙍','cliente_pessoa'=>'👥','pessoa_fisica'=>'🪪','pessoa_juridica'=>'🏦',
    'tel_cliente'=>'📱','endereco_cliente'=>'🗺️','reserva'=>'📅','checkin'=>'✅',
    'checkout'=>'💳','consumo'=>'🛒','hospedes'=>'🛎️','tel_hospede'=>'☎️'
];
?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Hotel Admin</title>
<link href="https://fonts.googleapis.com/css2?family=DM+Mono:wght@400;500&family=Syne:wght@400;600;700;800&display=swap" rel="stylesheet">
<style>
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

:root {
    --bg:       #0d0f14;
    --surface:  #13161e;
    --border:   #1f2330;
    --accent:   #6ee7b7;
    --accent2:  #818cf8;
    --danger:   #f87171;
    --text:     #e2e8f0;
    --muted:    #64748b;
    --sidebar-w: 240px;
}

body {
    font-family: 'Syne', sans-serif;
    background: var(--bg);
    color: var(--text);
    display: flex;
    min-height: 100vh;
}

/* ── Sidebar ── */
.sidebar {
    width: var(--sidebar-w);
    min-height: 100vh;
    background: var(--surface);
    border-right: 1px solid var(--border);
    display: flex;
    flex-direction: column;
    position: fixed;
    top: 0; left: 0;
    overflow-y: auto;
    z-index: 10;
}

.sidebar-logo {
    padding: 1.5rem 1.25rem 1rem;
    border-bottom: 1px solid var(--border);
}

.sidebar-logo h1 {
    font-size: 1.1rem;
    font-weight: 800;
    letter-spacing: -.02em;
    color: var(--accent);
    line-height: 1.2;
}

.sidebar-logo span {
    font-size: .7rem;
    color: var(--muted);
    font-family: 'DM Mono', monospace;
    text-transform: uppercase;
    letter-spacing: .1em;
}

.sidebar-nav { padding: .75rem 0; flex: 1; }

.nav-item {
    display: flex;
    align-items: center;
    gap: .6rem;
    padding: .55rem 1.25rem;
    text-decoration: none;
    color: var(--muted);
    font-size: .8rem;
    font-weight: 600;
    letter-spacing: .01em;
    transition: all .15s;
    border-left: 2px solid transparent;
}

.nav-item:hover {
    color: var(--text);
    background: rgba(110,231,183,.04);
}

.nav-item.active {
    color: var(--accent);
    border-left-color: var(--accent);
    background: rgba(110,231,183,.07);
}

.nav-item .icon { font-size: .95rem; }

/* ── Main ── */
.main {
    margin-left: var(--sidebar-w);
    flex: 1;
    padding: 2rem;
    min-height: 100vh;
}

.page-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 1.5rem;
    padding-bottom: 1rem;
    border-bottom: 1px solid var(--border);
}

.page-header h2 {
    font-size: 1.4rem;
    font-weight: 800;
    letter-spacing: -.03em;
}

.page-header h2 span {
    color: var(--accent);
    margin-right: .4rem;
}

.badge {
    font-family: 'DM Mono', monospace;
    font-size: .7rem;
    background: rgba(110,231,183,.1);
    color: var(--accent);
    padding: .2rem .6rem;
    border-radius: 999px;
    border: 1px solid rgba(110,231,183,.2);
}

/* ── Mensagem ── */
.msg {
    padding: .75rem 1rem;
    border-radius: 8px;
    margin-bottom: 1rem;
    font-size: .85rem;
    font-family: 'DM Mono', monospace;
}
.msg.ok  { background: rgba(110,231,183,.1); color: var(--accent); border: 1px solid rgba(110,231,183,.2); }
.msg.err { background: rgba(248,113,113,.1); color: var(--danger); border: 1px solid rgba(248,113,113,.2); }

/* ── Formulário ── */
.card {
    background: var(--surface);
    border: 1px solid var(--border);
    border-radius: 12px;
    padding: 1.5rem;
    margin-bottom: 1.5rem;
}

.card h3 {
    font-size: .85rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: .08em;
    color: var(--muted);
    margin-bottom: 1rem;
}

.form-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
    gap: .75rem;
    margin-bottom: 1rem;
}

.form-group label {
    display: block;
    font-size: .7rem;
    font-family: 'DM Mono', monospace;
    color: var(--muted);
    margin-bottom: .3rem;
    text-transform: uppercase;
    letter-spacing: .06em;
}

.form-group input {
    width: 100%;
    background: var(--bg);
    border: 1px solid var(--border);
    border-radius: 6px;
    padding: .5rem .75rem;
    color: var(--text);
    font-family: 'DM Mono', monospace;
    font-size: .82rem;
    outline: none;
    transition: border-color .15s;
}

.form-group input:focus {
    border-color: var(--accent);
    box-shadow: 0 0 0 2px rgba(110,231,183,.1);
}

.btn {
    display: inline-flex;
    align-items: center;
    gap: .4rem;
    padding: .5rem 1.1rem;
    border-radius: 6px;
    font-family: 'Syne', sans-serif;
    font-size: .8rem;
    font-weight: 700;
    cursor: pointer;
    border: none;
    text-decoration: none;
    transition: all .15s;
    letter-spacing: .02em;
}

.btn-primary {
    background: var(--accent);
    color: #0d0f14;
}
.btn-primary:hover { background: #a7f3d0; }

.btn-secondary {
    background: transparent;
    color: var(--muted);
    border: 1px solid var(--border);
}
.btn-secondary:hover { color: var(--text); border-color: var(--muted); }

.btn-danger {
    background: transparent;
    color: var(--danger);
    border: 1px solid rgba(248,113,113,.3);
    font-size: .72rem;
    padding: .3rem .7rem;
}
.btn-danger:hover { background: rgba(248,113,113,.1); }

.btn-edit {
    background: transparent;
    color: var(--accent2);
    border: 1px solid rgba(129,140,248,.3);
    font-size: .72rem;
    padding: .3rem .7rem;
}
.btn-edit:hover { background: rgba(129,140,248,.1); }

/* ── Tabela ── */
.table-wrap {
    overflow-x: auto;
    border-radius: 12px;
    border: 1px solid var(--border);
}

table {
    width: 100%;
    border-collapse: collapse;
    font-size: .82rem;
}

thead th {
    background: var(--surface);
    padding: .75rem 1rem;
    text-align: left;
    font-family: 'DM Mono', monospace;
    font-size: .68rem;
    text-transform: uppercase;
    letter-spacing: .08em;
    color: var(--muted);
    border-bottom: 1px solid var(--border);
    white-space: nowrap;
}

tbody tr {
    border-bottom: 1px solid var(--border);
    transition: background .1s;
}

tbody tr:last-child { border-bottom: none; }
tbody tr:hover { background: rgba(255,255,255,.02); }

tbody td {
    padding: .65rem 1rem;
    color: var(--text);
    font-family: 'DM Mono', monospace;
    white-space: nowrap;
}

tbody td.null-val { color: var(--muted); font-style: italic; }

.actions-cell { display: flex; gap: .4rem; align-items: center; }

.empty-state {
    text-align: center;
    padding: 3rem;
    color: var(--muted);
    font-size: .85rem;
}

/* ── Scroll sidebar ── */
.sidebar::-webkit-scrollbar { width: 4px; }
.sidebar::-webkit-scrollbar-track { background: transparent; }
.sidebar::-webkit-scrollbar-thumb { background: var(--border); border-radius: 2px; }
</style>
</head>
<body>

<!-- ══ SIDEBAR ══ -->
<aside class="sidebar">
    <div class="sidebar-logo">
        <h1>Hotel Admin</h1>
        <span>Painel de Dados</span>
    </div>
    <nav class="sidebar-nav">
        <?php foreach ($tabelas as $t): ?>
        <a href="?t=<?= $t ?>" class="nav-item <?= $t === $tabela_atual ? 'active' : '' ?>">
            <span class="icon"><?= $icones[$t] ?? '📋' ?></span>
            <?= $t ?>
        </a>
        <?php endforeach; ?>
    </nav>
</aside>

<!-- ══ MAIN ══ -->
<main class="main">

    <div class="page-header">
        <h2><span><?= $icones[$tabela_atual] ?? '📋' ?></span><?= $tabela_atual ?></h2>
        <span class="badge"><?= count($linhas) ?> registros</span>
    </div>

    <?= $msg ?>

    <!-- ── Formulário Inserir / Editar ── -->
    <div class="card">
        <h3><?= $edit_row ? '✏️ Editar Registro' : '➕ Novo Registro' ?></h3>
        <form method="POST" action="?t=<?= $tabela_atual ?>">
            <input type="hidden" name="_action" value="<?= $edit_row ? 'update' : 'insert' ?>">
            <input type="hidden" name="_pk"     value="<?= $pk ?>">
            <?php if ($edit_row): ?>
            <input type="hidden" name="_id"     value="<?= htmlspecialchars($edit_row[$pk]) ?>">
            <?php endif; ?>

            <div class="form-grid">
                <?php foreach ($colunas as $col):
                    if ($col['Key'] === 'PRI') continue;
                    $val = htmlspecialchars($edit_row[$col['Field']] ?? '');
                ?>
                <div class="form-group">
                    <label><?= $col['Field'] ?></label>
                    <input type="text" name="<?= $col['Field'] ?>" value="<?= $val ?>"
                           placeholder="<?= $col['Null'] === 'YES' ? 'opcional' : 'obrigatorio' ?>">
                </div>
                <?php endforeach; ?>
            </div>

            <div style="display:flex;gap:.5rem">
                <button type="submit" class="btn btn-primary">
                    <?= $edit_row ? '💾 Salvar' : '➕ Inserir' ?>
                </button>
                <?php if ($edit_row): ?>
                <a href="?t=<?= $tabela_atual ?>" class="btn btn-secondary">Cancelar</a>
                <?php endif; ?>
            </div>
        </form>
    </div>

    <!-- ── Tabela de dados ── -->
    <div class="table-wrap">
        <table>
            <thead>
                <tr>
                    <?php foreach ($colunas as $col): ?>
                    <th><?= $col['Field'] ?></th>
                    <?php endforeach; ?>
                    <th>Acoes</th>
                </tr>
            </thead>
            <tbody>
                <?php if (empty($linhas)): ?>
                <tr><td colspan="<?= count($colunas) + 1 ?>" class="empty-state">Nenhum registro encontrado.</td></tr>
                <?php else: ?>
                <?php foreach ($linhas as $linha): ?>
                <tr>
                    <?php foreach ($colunas as $col):
                        $v = $linha[$col['Field']];
                    ?>
                    <td <?= is_null($v) ? 'class="null-val"' : '' ?>>
                        <?= is_null($v) ? 'NULL' : htmlspecialchars($v) ?>
                    </td>
                    <?php endforeach; ?>
                    <td>
                        <div class="actions-cell">
                            <a href="?t=<?= $tabela_atual ?>&action=edit&id=<?= $linha[$pk] ?>"
                               class="btn btn-edit">Editar</a>
                            <a href="?t=<?= $tabela_atual ?>&action=delete&id=<?= $linha[$pk] ?>&pk=<?= $pk ?>"
                               class="btn btn-danger"
                               onclick="return confirm('Excluir este registro?')">Excluir</a>
                        </div>
                    </td>
                </tr>
                <?php endforeach; ?>
                <?php endif; ?>
            </tbody>
        </table>
    </div>

</main>
</body>
</html>
