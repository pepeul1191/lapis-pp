-- CONFIGURACIÓN DE LA APLICACIÓN
local lapis = require("lapis")
local app = lapis.Application()
local config = require("lapis.config").get()
local respond_to = require("lapis.application").respond_to
app:enable("etlua")

-- CARGA DE LIBRERÍAS
local helper = require("libs.helper")
local httparty = require("libs.httparty")

-- LOGIN Y ERRORES ... HANDLERS
local login = require("handlers.login")
local home = require("handlers.home")
local error = require("handlers.error")

-- MÓDULO ACCESOS ... HANDLERS
local permiso = require("handlers.accesos.permiso")

-- LOGIN Y ERRORES ... RUTAS
app:match("homeIndex", "/", respond_to(home.Index(self, config, helper)))
app:match("loginIndex", "/login", respond_to(login.Index(self, config, helper)))
app:match("loginAcceder", "/login/acceder", respond_to(login.Acceder(self, config, helper, httparty)))
app:match("loginSalir", "/salir", respond_to(login.Salir(self)))
app:match("loginVer", "/ver", respond_to(login.Ver(self)))
app:match("error404", "/error/access/404", respond_to(error.NoEncontrado(self, config, helper)))
app:match("error5050", "/error/access/5050", respond_to(error.NoLogueado(self, config, helper)))

-- MÓDULO ACCESOS ... RUTAS
app:match("accesosPermisoIndex", "/accesos/permisos", respond_to(permiso.Index(self, config, helper)))
app:match("accesosPermisoListar", "/accesos/permiso/listar", respond_to(permiso.Listar(self, config, helper, httparty)))
app:match("accesosPermisoGuardar", "/accesos/permiso/guardar", respond_to(permiso.Guardar(self, config, helper, httparty)))

-- HANDLERS DE ERRORES
--app.handle_404 = function(self)
  	--return {redirect_to = self:url_for("error404")}
--end

-- INICIO DE LA APLICACIÓN
return app