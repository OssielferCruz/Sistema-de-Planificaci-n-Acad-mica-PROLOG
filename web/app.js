const $ = (id) => document.getElementById(id);

const state = {
  materias: [],
};

const resultado = $("resultado");
const catalogo = $("catalogo");
const expediente = $("expediente");

function print(text) {
  resultado.textContent = text;
}

async function api(path, method = "GET", body) {
  const opts = { method, headers: {} };
  if (body) {
    opts.headers["Content-Type"] = "application/json";
    opts.body = JSON.stringify(body);
  }
  const res = await fetch(path, opts);
  const data = await res.json();
  if (!res.ok || data.ok === false) {
    throw new Error(data.error || "Error en la solicitud");
  }
  return data;
}

function materiaLabel(m) {
  return `[${m.codigo}] ${m.nombre} (C${m.cuatrimestre}, ${m.creditos} cr)`;
}

function fillSelect(select, list) {
  select.innerHTML = "";
  list.forEach((m) => {
    const o = document.createElement("option");
    o.value = m.codigo;
    o.textContent = materiaLabel(m);
    select.appendChild(o);
  });
}

async function cargarMaterias() {
  const data = await api("/api/materias");
  state.materias = data.materias;
  fillSelect(catalogo, state.materias);
}

async function cargarExpediente() {
  const data = await api("/api/expediente");
  const mats = data.expediente
    .map((codigo) => state.materias.find((m) => m.codigo === codigo))
    .filter(Boolean);
  fillSelect(expediente, mats);
}

function codigoCatalogo() {
  return catalogo.value;
}

function codigoExpediente() {
  return expediente.value;
}

function renderLista(cods) {
  if (!cods || cods.length === 0) return "(ninguna)";
  return cods
    .map((c) => state.materias.find((m) => m.codigo === c))
    .filter(Boolean)
    .map((m) => `- ${materiaLabel(m)}`)
    .join("\n");
}

function renderBloqueadas(list) {
  if (!list || list.length === 0) return "(ninguna)";
  return list
    .map(([codigo, faltantes]) => {
      const m = state.materias.find((x) => x.codigo === codigo);
      const nombre = m ? m.nombre : codigo;
      return `- [${codigo}] ${nombre} | Falta: ${faltantes.join(", ")}`;
    })
    .join("\n");
}

$("filtro").addEventListener("input", (e) => {
  const q = e.target.value.toLowerCase().trim();
  const filtradas = !q
    ? state.materias
    : state.materias.filter((m) =>
        `${m.codigo} ${m.nombre}`.toLowerCase().includes(q)
      );
  fillSelect(catalogo, filtradas);
});

$("btnMarcar").addEventListener("click", async () => {
  try {
    const codigo = codigoCatalogo();
    if (!codigo) return print("Selecciona una materia del catalogo.");
    await api("/api/expediente/agregar", "POST", { codigo });
    await cargarExpediente();
    print(`Materia [${codigo}] agregada al expediente.`);
  } catch (e) {
    print(e.message);
  }
});

$("btnQuitar").addEventListener("click", async () => {
  try {
    const codigo = codigoExpediente();
    if (!codigo) return print("Selecciona una materia del expediente.");
    await api("/api/expediente/quitar", "POST", { codigo });
    await cargarExpediente();
    print(`Materia [${codigo}] removida del expediente.`);
  } catch (e) {
    print(e.message);
  }
});

$("btnVerificar").addEventListener("click", async () => {
  try {
    const codigo = codigoCatalogo();
    if (!codigo) return print("Selecciona una materia del catalogo.");
    const d = await api("/api/verificar", "POST", { codigo });
    if (d.ya_aprobada) {
      print(`La materia [${codigo}] ya esta aprobada.`);
    } else if (d.habilitado) {
      print(`Puedes matricular [${codigo}].`);
    } else {
      print(`No puedes matricular [${codigo}]. Falta: ${d.faltantes.join(", ")}`);
    }
  } catch (e) {
    print(e.message);
  }
});

$("btnRuta").addEventListener("click", async () => {
  try {
    const codigo = codigoCatalogo();
    if (!codigo) return print("Selecciona una materia del catalogo.");
    const d = await api("/api/ruta", "POST", { codigo });
    print(
      `Ruta critica para [${codigo}]\n\n` +
      `Hacia atras:\n${renderLista(d.atras)}\n\n` +
      `Hacia adelante:\n${renderLista(d.adelante)}`
    );
  } catch (e) {
    print(e.message);
  }
});

$("btnSimular").addEventListener("click", async () => {
  try {
    const d = await api("/api/simular");
    print(
      `Simulador de matricula\n\n` +
      `Habilitadas:\n${renderLista(d.habilitadas)}\n\n` +
      `Bloqueadas:\n${renderBloqueadas(d.bloqueadas)}`
    );
  } catch (e) {
    print(e.message);
  }
});

$("btnRecomendar").addEventListener("click", async () => {
  try {
    const codigo = codigoCatalogo();
    if (!codigo) return print("Selecciona una materia del catalogo.");
    const d = await api("/api/recomendar", "POST", { codigo });
    print(
      `Recuperacion para [${codigo}]\n` +
      `Prioridad: ${d.prioridad}\n\n` +
      `Materias adelantables:\n${renderLista(d.adelantables)}`
    );
  } catch (e) {
    print(e.message);
  }
});

$("btnProgreso").addEventListener("click", async () => {
  try {
    const d = await api("/api/progreso");
    print(`Progreso\nAprobados: ${d.aprobados}\nRestantes: ${d.restantes}\nTotal: ${d.total}`);
  } catch (e) {
    print(e.message);
  }
});

$("btnGuardar").addEventListener("click", async () => {
  try {
    const archivo = $("archivo").value.trim() || "expediente_ice.pl";
    await api("/api/expediente/guardar", "POST", { archivo });
    print(`Expediente guardado en ${archivo}`);
  } catch (e) {
    print(e.message);
  }
});

$("btnCargar").addEventListener("click", async () => {
  try {
    const archivo = $("archivo").value.trim() || "expediente_ice.pl";
    await api("/api/expediente/cargar", "POST", { archivo });
    await cargarExpediente();
    print(`Expediente cargado desde ${archivo}`);
  } catch (e) {
    print(e.message);
  }
});

(async function init() {
  try {
    await cargarMaterias();
    await cargarExpediente();
    print("Listo. Selecciona una materia para comenzar.");
  } catch (e) {
    print(`Error inicial: ${e.message}`);
  }
})();
