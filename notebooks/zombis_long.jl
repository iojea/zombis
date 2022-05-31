### A Pluto.jl notebook ###
# v0.19.5

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ ac901706-a470-47ba-8351-f9e87869ab9a
begin
	using PlutoUI
	using Plots
	theme(:dracula)
end

# ╔═╡ ec7ab690-a52c-11ec-1e8a-f77727daef1a
html"""<h1 class="title">Cómo sobrevivir a una invasión zombi: ¡usando matemática!</h1>
	<script>
		const prefersDarkScheme = window.matchMedia('(prefers-color-scheme: dark)');
		export prefersDarkScheme;
	</script>
	<style> 
		@media (prefers-color-scheme: dark) {
  			.title {
			background: #333333;
			border-radius: 12px;
			text-align: center;
			padding: 0px 10px 0px 10px;
			color: #5090BB;}
		}
		@media (prefers-color-scheme: light) {
			.title {
			background: #EEEEEE;
			border-radius: 12px;
			text-align: center;
			padding: 0px 10px 0px 10px;
			color: #BB6050;}
		}
	</style>"""

# ╔═╡ 696e597a-45f0-44b9-b47e-a877abb87ab0
html"""<h2 class="title">Primera Parte</h2>"""

# ╔═╡ 3a5b4a4f-7955-475f-9d02-448572a3e63a
md"""Supongamos primero que todos los humanos vivimos en un edificio y salimos todos juntos para ver si hay más zombis. Cada vez que salimos, se infecta la mitad del grupo. Veamos cómo evoluciona la cantidad de humanos:"""

# ╔═╡ 7e7c5630-0999-401a-94ea-4e921c96d936
let
	url = "http://mate.dm.uba.ar/%7Eiojea/figura.png"
	data = read(download(url))
	PlutoUI.Show(MIME"image/jpg"(), data)
end

# ╔═╡ 2a86adbe-972a-4dd9-845d-609b187879bf
md"""Supongamos ahora que todos los humanos vivimos en un edificio y salimos todos juntos para ver si hay más zombis. Pero cada vez que salimos, se infecta la décima parte del grupo:

 $\begin{array}{cccc}
   h_0 & \phantom{aa} & h_1=h_0-\frac{h_0}{10} & \dots \\ 
   t=0 & \phantom{aa} & t=1 & \dots \\
  \end{array}$

 ¿Cuántos humanos somos a tiempo $n$ con respecto a lo que había al principio?

 $\begin{align*}
 h_{n+1} &= h_n-\frac{1}{10}h_{n}\\ 
         &= \bigg(\frac{9}{10}\bigg) h_n \\
         &= \bigg(\frac{9}{10}\bigg)\bigg(\frac{9}{10}\bigg) h_{n-1} \\
         &= \bigg(\frac{9}{10}\bigg)^2 h_{n-1} \\
         &= \dots  \\
         &= \bigg(\frac{9}{10}\bigg)^{n+1} h_0 
   \end{align*}$

 ¿Cómo será el gráfico de la cantidad de humanos en función del tiempo?"""

# ╔═╡ 4800127a-30be-4594-bc4e-6bb6c9c3149b
md"""Pensemos ahora en la cantidad de zombis que, cada vez que salen los humanos, aumenta (porque los humanos se convierten en zombis). Supongamos que estamos en un caso donde, cada vez que salen los humanos, la cantidad de zombis aumenta en un décimo:

$\begin{array}{cccc}
   z_0 & \phantom{aa} & z_1=z_0+\frac{z_0}{10} & \dots \\ 
   t=0 & \phantom{aa} & t=1 & \dots \\
  \end{array}$

 ¿Cuántos zombis hay a tiempo $n$ con respecto a lo que había al principio? Razonamos como antes:

$z_{n+1} = z_n+\frac{1}{10}z_n = \Big(\frac{11}{10}\Big)z_n = \dots = \Big(\frac{11}{10}\Big)^{n+1} z_0$

¿Cómo sería un gráfico de la cantidad de zombis en función del tiempo?"""

# ╔═╡ c8262dd6-5c56-4786-be3a-9d37486a7c03
md"""Conclusión, en cada caso tenemos que:

$h_{n}=\alpha^n h_0, \hspace{2cm} z_{n}=\beta^n z_0,$

para ciertos valores de $\alpha$ y $\beta$,  

¿Qué podemos deducir del comportamiento cuando el tiempo $n$ se hace cada vez más grande?"""

# ╔═╡ d52565c5-e983-40d2-ab65-c76bfc3fcc01
html"""<h3 class="title">Crecimiento con natalidad y mortalidad</h3>"""

# ╔═╡ 097d4c17-5966-4ef5-962d-c6545091e97c
md"""
Suponemos que la  población tiene la siguiente dinámica: en un instante de tiempo, la cantidad de humanos $h_{n+1}$ es igual a la que había en el instante anterior, $h_n$, agregando los qe nacen $+N h_n$, y restando las muertes $-M h_n$ (observar que los nacimientos y fallecimientos son proporcionales a la cantidad de humanos). Esto se puede escribir como


$\begin{align*}
	 h_{n+1}&:=h_n +N h_n - M h_n \\
	 &=h_n+(N-M)h_n\\
	 &=(1+N-M)h_n\\
	 &:=\beta h_n
\end{align*}$

donde $h_n$ representa la cantidad de humanos en el instante $n$, siendo $n$ por ejemplo, años."""

# ╔═╡ ed49e3ed-dd07-44bb-b5a5-ef86c9332859
md"""

1.   Si inicialmente hay $h_0$ humanos y sabemos que:

  *   La tasa de natalidad es del $\mathcal{N}\%$ anual, es decir: $N=\frac{\mathcal{N}}{100}$.
  *   La tasa de mortalidad es de $\mathcal{M}\%$ anual, es decir: $M=\frac{\mathcal{M}}{100}$.

    La pregunta es: ¿Cuántos zombis habrá dentro de $15$ años?

    Moviendo los siguientes deslizadores se puede observar el comportamiento de la población de zombis dependiendo de los parámetros:"""

# ╔═╡ d07a8fee-051b-4167-9d92-d4474803e03d
md"""
 h₀ = $(@bind h₁₀ Slider(1000:10:10000,default=1000,show_value=true)) 

 N = $(@bind N₁ Slider(0:0.01:1,default=0.5,show_value=true)) 

 M = $(@bind M₁ Slider(0:0.01:1,default=0.3,show_value=true))
"""
#= El nombre verdadero de las variables es h₁₀, N₁ y M₁. 
Esto es para no repetir nombres más adelante. 
El subíndice 1 indica que son los datos para el primer modelo. 
Para escribir un subíndice 1 hay que tipear: \_1 y luego "tab".
=#

# ╔═╡ e4f95747-ab32-47df-bf4d-359aec4b81fc
begin 
	tiempo₁ = 15        #Defino el tiempo que va a durar la simulación
	h₁      = zeros(tiempo₁+1)  #Genero una tira de ceros para ir rellenando
	h₁[1]   = h₁₀               #Cargo la población inicial (con lo que devuelve el slider)
	β₁      = round(1+N₁-M₁,digits=2) # Calculo el β y lo redondeo
	for i in 2:tiempo₁+1       # a lo largo del tiempo, voy calculando la població. 
		h₁[i] = β₁*h₁[i-1]
	end
	scatter(0:tiempo₁,h₁,legend=:top,label="Humanos", title="Evolución con β= $β₁") #grafico
end

# ╔═╡ b12e6b22-0626-46d5-9608-480f454712f3
md"""¿Qué ocurre si hay más natalidad que mortalidad? 

 ¿Qué ocurre si hay más muertes que nacimientos? 

¿Qué ocurre si las muertes y los nacimientos se equiparan?"""

# ╔═╡ 3ef542df-44a1-43af-872e-1138c12eb17f
html"""<h2 class="title">Competencia entre especies</h2>"""

# ╔═╡ 51443cff-ad5e-4d21-98ac-3256198e7a11
md"""2.   A diferencia del modelo anterior, la cantidad de zombis y la cantidad de humanos dependen una de la otra. Empecemos suponiendo simplemente que la cantidad de zombis aumenta proporcionalmente a la cantidad de humanos. Entonces: 
$$\left\lbrace\begin{array}{rcl}h_{n+1} & = & h_n-\alpha h_n \\ z_{n+1} & = & z_n+\alpha h_n \end{array}\right.$$
¿Cómo es la evolución de las poblaciones?"""



# ╔═╡ 3179374a-be70-4025-8510-f5986a779539
md"""
 z₀ = $(@bind z₂₀ Slider(1:10:1000,default=1,show_value=true)) 

 h₀ = $(@bind h₂₀ Slider(1000:10:10000,default=1000,show_value=true)) 

 α = $(@bind α₂ Slider(0:0.01:1,default=0.01,show_value=true)) 
"""

# ╔═╡ 279340ea-7814-4c42-a4e6-79554262be86
md"""$(@bind mostrar_total₂ CheckBox()) Población total"""

# ╔═╡ 51d07f6d-f76d-4662-a71c-10422bef505f
begin
	tiempo₂ = 15
	h₂      = zeros(tiempo₂+1)
	z₂      = zeros(tiempo₂+1)
	h₂[1] = h₂₀
	z₂[1] = z₂₀
	for i in 2:tiempo₂+1
		h₂[i] = h₂[i-1] - α₂*h₂[i-1]
		z₂[i] = z₂[i-1] + α₂*h₂[i-1]
	end
	if mostrar_total₂
		scatter(0:tiempo₂,z₂,legend=:bottom,label="zombis",title="Evolución con α=$α₂")
		scatter!(0:tiempo₂,h₂,label="humanos")
		scatter!(0:tiempo₂,h₂+z₂,label="total")
	else
		scatter(0:tiempo₂,z₂,legend=:bottom,label="zombis",title="Evolución con α=$α₂")
		scatter!(0:tiempo₂,h₂,label="humanos")
	end
end

# ╔═╡ 8abac52d-9d1f-460c-b307-4a9425696520
md"""¿Influyen las cantidades iniciales de zombis y humanos en la dinámica?

¿Cambia la población total? ¿Por qué?

Una linda forma de visualizar la información es con un  gráfico de áreas. ¿Cómo se interpreta este gráfico?"""

# ╔═╡ b7d5379b-ce50-41c5-bc31-cb37c777ac80
begin
	plot(0:tiempo₂,z₂,legend=:bottom,label="zombis",fillrange=1,title="Evolución con α=$α₂")
	plot!(0:tiempo₂,h₂+z₂,label="humanos",fillrange=z₂)
end

# ╔═╡ 9831f016-6497-4984-bc54-749b112cd384
md"""3.   También podemos pensar que la cantidad de humanos decrece de manera proporcional a la cantidad de zombis, mientras que los zombis aumentan de manera proporcional a la cantidad de humanos, pero con parámetros distintos:

$\left\lbrace\begin{array}{rcl}h_{n+1} & = & h_n-\alpha z_n \\ z_{n+1} & = & z_n+\beta h_n \end{array}\right.$
"""

# ╔═╡ 5487a745-e091-42ea-9e37-4b929df74822
md"""
 z₀ = $(@bind z₃₀ Slider(1:3:100,default=10,show_value=true)) 

 h₀ = $(@bind h₃₀ Slider(1000:10:10000,default=1000,show_value=true)) 

 α = $(@bind α₃ Slider(0:0.01:1,default=0.05,show_value=true)) 
 
 β = $(@bind β₃ Slider(0:0.01:1,default=0.05,show_value=true)) 

tiempo = $(@bind tiempo₃ Slider(15:1:100,default=15,show_value=true)) 
"""

# ╔═╡ 444eb6b1-fc1d-4f82-ad0a-c19fc2511284
md"""$(@bind gtot2 CheckBox()) Población total"""

# ╔═╡ 2208fc1f-fed7-40ca-83a6-e24f6d374eae
begin
	h₃      = zeros(tiempo₃+1)
	z₃      = zeros(tiempo₃+1)
	h₃[1]   = h₃₀
	z₃[1]   = z₃₀
	for i in 2:tiempo₃+1
		h₃[i] = max(h₃[i-1] - α₃*z₃[i-1],0) #tomamos el máximo entre la cuenta y 0 para evitar que la cuenta de poblaciones negativas
		z₃[i] = max(z₃[i-1] + β₃*h₃[i-1],0)
	end
	if gtot2
		scatter(0:tiempo₃,z₃,legend=:right,label="zombis",title="Evolución con α=$α₃ y β=$β₃")
		scatter!(0:tiempo₃,h₃,label="humanos")
		scatter!(0:tiempo₃,z₃+h₃,label="total")
	else
		scatter(0:tiempo₃,z₃,legend=:top,label="zombis")
		scatter!(0:tiempo₃,h₃,label="humanos")
	end
end

# ╔═╡ 0c083f3d-13a0-4ed8-a892-65e9ec8f4062
md"""¿Cómo varía la cantidad de humanos si hay muchos zombis? ¿Y si hay pocos? 

 ¿Qué pasa con los zombis? ¿Y después de un largo tiempo, qué pasa?

 ¿Qué ocurre con la cantidad total de individuos (humanos + zombis), dependiendo de α y β?"""

# ╔═╡ f91360f0-158a-4232-b62d-695a3dc14d70
md"""Nuevamente, podemos ver la información de otra manera con un gráfico de áreas:"""

# ╔═╡ bc2820f8-59e9-4b3d-96b2-e9b6cf29bbf3
begin 
	plot(0:tiempo₃,z₃,label="zombis",fillrange=1)
	plot!(0:tiempo₃,h₃+z₃,label="humanos",fillrange=z₃)
end

# ╔═╡ 31eed41d-dc07-4764-b159-0a86f594f960
md"""¿Cómo se interpreta este gráfico?"""

# ╔═╡ bdeb879f-dde0-4ac5-9413-d5de4e3dda76
md"""En este modelo, ¿hay alguna chance de que, a largo plazo, los humanos sobrevivan? """

# ╔═╡ 6b2ea6e3-8a31-4032-8f2f-4088c78fa15a
md""" 
4.  Veamos un modelo más complejo. Consideremos los siguiente:

  *   Los humanos nacemos proporcionalmente a nuestra población (a tasa $N$),
  *   Los humanos morimos por causas ajenas a los zombis proporcionalmente a nuestra población (a tasa $M$),
  *   Para que un humano se convierta en zombi, se tiene que encontrar un humano con un zombi, tiene que haber interacción y hay una tasa de efectividad con la que los zombis logran contagiar a los humanos ($a$),
  *   Los zombis no se reproducen ni mueren por causas naturales.
  *   Los zombis pueden morir cuando hay encuentro con humanos porque los humanos los matamos con una cierta tasa de efectividad ($b$).

    Las ecuaciones quedan:
  
$\left\lbrace\begin{array}{rcl}h_{n+1} & = & h_n+N h_n-M h_n - a h_n z_n \\ 
z_{n+1} & = & z_n+a h_n z_n -b h_n z_n \\
\end{array}\right.$"""



# ╔═╡ b979ab88-6cf4-4782-b45b-e812cf87ba36
md"""Graficamos la situación asumiendo que en un comienzo hay 1000 humanos y 5 zombis. Como referencia: la tasa de natalidad anual de la Argentina es de 17 por mil (0.017), mientras que la tasa de mortalidad es de 8 por mil. 

¿Es posible encontrar valores de los parámetros que conduzcan a una convivencia de humanos y zombis? ¿O siempre hay una de las dos *especies* que, a la larga, se extingue? """

# ╔═╡ ba00baca-f3b2-4ee4-8332-547d3590a2b8
md"""
 N = $(@bind N₄ Slider(0:0.001:0.05,default=0.001,show_value=true)) 

 M = $(@bind M₄ Slider(0:0.001:0.05,default=0.001,show_value=true)) 

 a = $(@bind a₄ Slider(0:0.0001:0.002,default=0.001,show_value=true)) 
 
 b = $(@bind b₄ Slider(0:0.0001:0.002,default=0.001,show_value=true)) 

tiempo = $(@bind tiempo₄ Slider(10:500,default=20,show_value=true)) 
"""

# ╔═╡ e139d1a2-27ba-4252-9544-81f3d91f8de9
md"""$(@bind gtot3 CheckBox()) Población total"""

# ╔═╡ 7583b506-778d-4000-b308-57d9192a4ead
begin
	h₄    = zeros(tiempo₄+1)
	z₄    = zeros(tiempo₄+1)
	h₄[1] = 1000
	z₄[1] = 20
	for i in 2:tiempo₄+1
		h₄[i] = max(h₄[i-1] + (N₄-M₄)*h₄[i-1] - a₄*h₄[i-1]*z₄[i-1],0)
		z₄[i] = max(z₄[i-1] + (a₄-b₄)*h₄[i-1]*z₄[i-1],0)
	end
	if gtot3
		scatter(0:tiempo₄,z₄,legend=:top,label="zombis")
		scatter!(0:tiempo₄,h₄,label="humanos")
		scatter!(0:tiempo₄,z₄+h₄,label="total")
	else
		scatter(0:tiempo₄,z₄,legend=:top,label="zombis")
		scatter!(0:tiempo₄,h₄,label="humanos")
	end
end

# ╔═╡ d189d858-e793-4571-a836-3ee3ef94b8f4
md"""¿Qué ocurre con las poblaciones si $a>b$? ¿Y si $b>a$?

¿Se ven posibilidades de que ambas poblaciones convivan con el tiempo?"""

# ╔═╡ 7014b7a0-62c9-48d5-9aaa-4e84053da67e
md"""
6. Se puede observar una dinámica interesante si tenemos la suerte de que aparezca un virus que mate zombis. En tal caso, tendríamos una ayudita en la reducción de zombis. Lo podemos plantear así:

  * Los humanos, si no hubiera zombis, crecerían a una tasa $\beta>1$. (Ya vimos que $\beta = 1+N-M$). 
  * Los zombis, si no hubiera humanos, decrecerían a una tasa $\alpha<1$ Este $\alpha$ sería simplemente $1$ menos la mortalidad de los zombis por culpa del virus.
  * Además, tenemos las interacciones, como en el modelo anterior. 

Las ecuaciones quedan:

$\left\lbrace\begin{array}{rcl}h_{n+1} & = & \beta h_n - a h_n z_n \\ 
z_{n+1} & = & \alpha z_n+(a-b) h_n z_n \\
\end{array}\right.$
"""

# ╔═╡ a33ee682-82c0-4b63-a7c8-dcf885003921
md"""
 a = $(@bind a₅ Slider(0:0.001:0.01,default=0.001,show_value=true)) 
 
 b = $(@bind b₅ Slider(0:0.001:0.01,default=0.001,show_value=true)) 

 β = $(@bind β₅ Slider(1:0.0001:1.05,default=1.01,show_value=true))

 α = $(@bind α₅ Slider(0:0.0001:0.99,default=0.1,show_value=true))

tiempo = $(@bind tiempo₅ Slider(10:10:500,default=20,show_value=true)) 
"""

# ╔═╡ dfa63e76-ca49-440f-91f1-bb6e1e605c72
md"""$(@bind mostrar_total₅ CheckBox()) Población total"""

# ╔═╡ 9a644400-a5f1-4771-9ff8-9b610376cf3e
begin
	h₅    = zeros(tiempo₅+1)
	z₅    = zeros(tiempo₅+1)
	h₅[1] = 1000
	z₅[1] = 5
	for i in 2:tiempo₅+1
		h₅[i] = max(β₅*h₅[i-1] - a₅*h₅[i-1]*z₅[i-1],0)
		z₅[i] = max(α₅*z₅[i-1] + (a₅-b₅)*h₅[i-1]*z₅[i-1],0)
	end
	if mostrar_total₅
		plot(0:tiempo₅,z₅,legend=:top,label="zombis")
		plot!(0:tiempo₅,h₅,label="humanos")
		plot!(0:tiempo₅,h₅+z₅,label="total")
	else
		plot(0:tiempo₅,z₅,legend=:top,label="zombis")
		plot!(0:tiempo₅,h₅,label="humanos")
	end
end

# ╔═╡ 037558b0-ed72-470f-a65a-f9a5df04e0b2
html"""<h2 class="title">Modelos epidémicos</h2>"""

# ╔═╡ dab82d69-8a98-465f-bbc3-da791552adf7
md"""6. Consideremos el modelo para enfermedades infecciosas $SI$:

 * Hay una población suceptible de contagiarse (los sanos), $S$ y una población de infectados,  $I$. 
 * La población general ($S+I$) tiene una cierta tasa de natalidad ($N$). 
 * La población sana tiene una cierta tasa de mortalidad, independiente de la enfermedad ($M$).
 * La población infectada tiene otra tasa de mortalidad ($m$).
 * Las interacciones producen contagios, a una cierta tasa. 

Las ecuaciones quedan: 

$\left\lbrace\begin{array}{rcl}
S_{n+1} & = & S_n+ N(S_n+I_n)-M S_n - a S_n I_n \\ 
I_{n+1} & = & I_n - m I_n + a S_n I_n \\
\end{array}\right.$
"""


# ╔═╡ 1a222185-2e57-4ed4-a70b-317e641366ab
md"""Para simplificar el análisis, tomamos $N=0.017$ y $m_1=0.008$, que son las tasas de natalidad y mortalidad de la Argentina. Asumimos que la población inicial está formada por $1000$ suceptibles y $5$ infectados. """

# ╔═╡ b829c2b9-42e7-4a35-822b-8d202b0f883f
md"""
 m = $(@bind m₆ Slider(0.1:0.01:0.2,default=0.001,show_value=true)) 
 
 a = $(@bind a₆ Slider(0:0.0001:0.001,default=0.001,show_value=true)) 

tiempo = $(@bind tiempo₆ Slider(10:1500,default=20,show_value=true)) 
"""

# ╔═╡ ce983e3e-fb57-45ad-9617-0cf0e5518778
md"""$(@bind total CheckBox()) Población Total"""

# ╔═╡ bb27b253-1894-4ee5-abbd-e64df9d0feb9
begin
	N₆    = 0.017
	M₆    = 0.008
	S₆    = zeros(tiempo₆+1)
	I₆    = zeros(tiempo₆+1)
	S₆[1] = 1000
	I₆[1] = 5
	for i in 2:tiempo₆+1
		S₆[i] = max(S₆[i-1] + N₆*(S₆[i-1]+I₆[i-1]) - M₆*S₆[i-1]-a₆*S₆[i-1]*I₆[i-1],0)
		I₆[i] = max(I₆[i-1] - m₆*I₆[i-1] + a₆*S₆[i-1]*I₆[i-1],0)
	end

	if total
		plot(0:tiempo₆,S₆,legend=:top,label="S")
		plot!(0:tiempo₆,I₆,label="I")
		plot!(0:tiempo₆,S₆+I₆,label="Total")
	else
		plot(0:tiempo₆,S₆,legend=:top,label="S")
		plot!(0:tiempo₆,I₆,label="I")
	end
	
end

# ╔═╡ 23c6a842-6ed4-42d4-a56c-c821035a1453
md"""¿Qué se observa? ¿Cómo es el comportamiento de las curvas al cambiar los parámetros? 

Probar con $m_2=0.15$ y $a=0.0005$. ¿Qué se ve a largo plazo? ¿Cómo debe interpretarse el gráfico?"""



# ╔═╡ 1f2a6398-3233-4efa-8ad5-6e608e2912d8
md"""Podemos complementar con un gráfico de áreas:"""

# ╔═╡ dd8f5133-cfea-4947-af66-113f93a0c004
begin
	plot(0:tiempo₆,S₆,fillrange=1,label="Susceptibles",title="Evolución con a=$a₆, m=$m₆")
	plot!(0:tiempo₆,I₆+S₆,fillrange=S₆,label="Infectados")
end

# ╔═╡ 725c4b76-0351-4ef7-b959-e17cc0f2fee2
md"""7. Por último, consideremos el modelo que agrega un tratamiento, es decir: existe una tasa $v$ de curación, que convierte infectados en susceptibles. 

$\left\lbrace\begin{array}{rcl}
S_{n+1} & = & S_n+ N(S_n+I_n)-M S_n - a S_n I_n +vI_n \\ 
I_{n+1} & = & I_n - m I_n + a S_k I_n -vI_n\\
\end{array}\right.$

Volvemos a dejar fijos los valores de $N$ y $M$ y de las poblaciones iniciales, para estudiar el efecto de los parámetros $m$, $a$ y $v$. """

# ╔═╡ 0c46405c-ffc0-4141-b35d-dee42692c2c1
md"""
 m = $(@bind m₇ Slider(0.1:0.01:0.2,default=0.2,show_value=true))

 a = $(@bind a₇ Slider(0:0.0001:0.001,default=0.001,show_value=true))

 v = $(@bind v₇ Slider(0:0.001:1,default=0.4,show_value=true))

tiempo = $(@bind tiempo₇ Slider(10:1500,default=20,show_value=true)) 
"""

# ╔═╡ 97a12090-5923-47c3-9487-d936ee26e294
md"""$(@bind totv CheckBox()) Población Total"""

# ╔═╡ 81ef7961-9632-4730-b0d3-1d3689d79871
begin
	N₇    = 0.017
	M₇    = 0.008
	S₇    = zeros(tiempo₇+1)
	I₇    = zeros(tiempo₇+1)
	S₇[1] = 1000
	I₇[1] = 5
	for i in 2:tiempo₇+1
		S₇[i] = max(S₇[i-1] + N₇*(S₇[i-1]+I₇[i-1]) - M₇*S₇[i-1]-a₇*S₇[i-1]*I₇[i-1]+v₇*I₇[i-1],0)
		I₇[i] = max(I₇[i-1] - m₇*I₇[i-1] + a₇*S₇[i-1]*I₇[i-1]-v₇*I₇[i-1],0)
	end

	if totv
		plot(0:tiempo₇,S₇,legend=:top,label="S")
		plot!(0:tiempo₇,I₇,label="I")
		plot!(0:tiempo₇,S₇+I₇,label="Total")
	else
		plot(0:tiempo₇,S₇,legend=:top,label="S")
		plot!(0:tiempo₇,I₇,label="I")
	end
	
end

# ╔═╡ fc9463b4-63ad-4e9f-99e7-5854d039c855
begin
	plot(0:tiempo₇,S₇,fillrange=1,label="Susceptibles",title="Evolución con m=$m₇, a=$a₇, v=$v₇")
	plot!(0:tiempo₇,I₇+S₇,fillrange=S₇,label="Infectados")
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
Plots = "~1.27.6"
PlutoUI = "~0.7.38"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.2"
manifest_format = "2.0"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "af92965fb30777147966f58acb05da51c5616b5f"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.3.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "19a35467a82e236ff51bc17a3a44b69ef35185a2"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+0"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b859a208b2397a7a623a03449e4636bdb17bcf2"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+1"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "9950387274246d08af38f6eef8cb5480862a435f"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.14.0"

[[deps.ChangesOfVariables]]
deps = ["ChainRulesCore", "LinearAlgebra", "Test"]
git-tree-sha1 = "bf98fa45a0a4cee295de98d4c1462be26345b9a1"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.2"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "Colors", "FixedPointNumbers", "Random"]
git-tree-sha1 = "12fc73e5e0af68ad3137b886e3f7c1eacfca2640"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.17.1"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "417b0ed7b8b838aa6ca0a87aadf1bb9eb111ce40"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.8"

[[deps.Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "b153278a25dd42c65abbf4e62344f9d22e59191b"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.43.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Contour]]
deps = ["StaticArrays"]
git-tree-sha1 = "9f02045d934dc030edad45944ea80dbd1f0ebea7"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.5.7"

[[deps.DataAPI]]
git-tree-sha1 = "fb5f5316dd3fd4c5e7c30a24d50643b73e37cd40"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.10.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "3daef5523dd2e769dad2365274f760ff5f282c7d"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.11"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "b19534d1895d702889b219c382a6e18010797f0b"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.8.6"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.EarCut_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3f3a2501fa7236e9b911e0f7a588c657e822bb6d"
uuid = "5ae413db-bbd1-5e63-b57d-d24a61df00f5"
version = "2.2.3+0"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bad72f730e9e91c08d9427d5e8db95478a3c323d"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.4.8+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "Pkg", "Zlib_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "d8a578692e3077ac998b50c0217dfd67f21d1e5f"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.0+0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "87eb71354d8ec1a96d4a7636bd57a7347dde3ef9"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.10.4+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "51d2dfe8e590fbd74e7a842cf6d13d8a2f45dc01"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.6+0"

[[deps.GR]]
deps = ["Base64", "DelimitedFiles", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Printf", "Random", "RelocatableFolders", "Serialization", "Sockets", "Test", "UUIDs"]
git-tree-sha1 = "af237c08bda486b74318c8070adb96efa6952530"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.64.2"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Pkg", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "cd6efcf9dc746b06709df14e462f0a3fe0786b1e"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.64.2+0"

[[deps.GeometryBasics]]
deps = ["EarCut_jll", "IterTools", "LinearAlgebra", "StaticArrays", "StructArrays", "Tables"]
git-tree-sha1 = "83ea630384a13fc4f002b77690bc0afeb4255ac9"
uuid = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
version = "0.4.2"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "a32d672ac2c967f3deb8a81d828afc739c838a06"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.68.3+2"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "Dates", "IniFile", "Logging", "MbedTLS", "NetworkOptions", "Sockets", "URIs"]
git-tree-sha1 = "0fa77022fe4b511826b39c894c90daf5fce3334a"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "0.9.17"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
git-tree-sha1 = "2b078b5a615c6c0396c77810d92ee8c6f470d238"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.3"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.IniFile]]
git-tree-sha1 = "f550e6e32074c939295eb5ea6de31849ac2c9625"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.1"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "91b5dcf362c5add98049e6c29ee756910b03051d"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.3"

[[deps.IrrationalConstants]]
git-tree-sha1 = "7fd44fd4ff43fc60815f8e764c0f352b83c49151"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.1.1"

[[deps.IterTools]]
git-tree-sha1 = "fa6287a4469f5e048d763df38279ee729fbd44e5"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.4.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b53380851c6e6664204efb2e62cd24fa5c47e4ba"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "2.1.2+0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f2355693d6778a178ade15952b7ac47a4ff97996"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.0"

[[deps.Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "Printf", "Requires"]
git-tree-sha1 = "6f14549f7760d84b2db7a9b10b88cd3cc3025730"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.14"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "7739f837d6447403596a75d19ed01fd08d6f56bf"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.3.0+3"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "42b62845d70a619f063a7da093d995ec8e15e778"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+1"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "c9551dd26e31ab17b86cbd00c2ede019c08758eb"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.3.0+1"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "44a7b7bb7dd1afe12bac119df6a7e540fa2c96bc"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.13"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "3d3e902b31198a27340d0bf00d6ac452866021cf"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.9"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "Random", "Sockets"]
git-tree-sha1 = "1c38e51c3d08ef2278062ebceade0e46cefc96fe"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.0.3"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.Measures]]
git-tree-sha1 = "e498ddeee6f9fdb4551ce855a46f54dbd900245f"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.1"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "bf210ce90b6c9eed32d25dbcae1ebc565df2687f"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.2"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.NaNMath]]
git-tree-sha1 = "737a5957f387b17e74d4ad2f440eb330b39a62c5"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.0"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ab05aa4cc89736e95915b01e7279e61b1bfe33b8"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.14+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.PCRE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b2a7af664e098055a7529ad1a900ded962bca488"
uuid = "2f80f16e-611a-54ab-bc61-aa92de5b98fc"
version = "8.44.0+0"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "1285416549ccfcdf0c50d4997a94331e88d68413"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.3.1"

[[deps.Pixman_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b4f5d02549a10e20780a24fce72bea96b6329e29"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.40.1+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "8162b2f8547bc23876edd0c5181b27702ae58dce"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.0.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "bb16469fd5224100e422f0b027d26c5a25de1200"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.2.0"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "GeometryBasics", "JSON", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "Unzip"]
git-tree-sha1 = "6f2dd1cf7a4bbf4f305a0d8750e351cb46dfbe80"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.27.6"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "670e559e5c8e191ded66fa9ea89c97f10376bb4c"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.38"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "47e5f437cc0e7ef2ce8406ce1e7e24d44915f88d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.3.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "c6c0f690d0cc7caddb74cef7aa847b824a16b256"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+1"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RecipesBase]]
git-tree-sha1 = "6bf3f380ff52ce0832ddd3a2a7b9538ed1bcca7d"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.2.1"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "RecipesBase"]
git-tree-sha1 = "dc1e451e15d90347a7decc4221842a022b011714"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.5.2"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "cdbd3b1338c72ce29d9584fdbe9e9b70eeb5adca"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "0.1.3"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "0b4b7f1393cff97c33891da2a0bf69c6ed241fda"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.1.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "Random", "Statistics"]
git-tree-sha1 = "cd56bf18ed715e8b09f06ef8c6b781e6cdc49911"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.4.4"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "c82aaa13b44ea00134f8c9c89819477bd3986ecd"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.3.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "8977b17906b0a1cc74ab2e3a05faa16cf08a8291"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.16"

[[deps.StructArrays]]
deps = ["Adapt", "DataAPI", "StaticArrays", "Tables"]
git-tree-sha1 = "57617b34fa34f91d536eb265df67c2d4519b8b98"
uuid = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
version = "0.6.5"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "OrderedCollections", "TableTraits", "Test"]
git-tree-sha1 = "5ce79ce186cc678bbb5c5681ca3379d1ddae11a1"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.7.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.URIs]]
git-tree-sha1 = "97bbe755a53fe859669cd907f2d96aee8d2c1355"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.3.0"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unzip]]
git-tree-sha1 = "34db80951901073501137bdbc3d5a8e7bbd06670"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.1.2"

[[deps.Wayland_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "3e61f0b86f90dacb0bc0e73a0c5a83f6a8636e23"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.19.0+0"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4528479aa01ee1b3b4cd0e6faef0e04cf16466da"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.25.0+0"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "1acf5bdf07aa0907e0a37d3718bb88d4b687b74a"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.9.12+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "5be649d550f3f4b95308bf0183b82e2582876527"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.6.9+4"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4e490d5c960c314f33885790ed410ff3a94ce67e"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.9+4"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fe47bd2247248125c428978740e18a681372dd4"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.3+4"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6783737e45d3c59a4a4c4091f5f88cdcf0908cbb"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.0+3"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "daf17f441228e7a3833846cd048892861cff16d6"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.13.0+3"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "926af861744212db0eb001d9e40b5d16292080b2"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.0+4"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "4bcbf660f6c2e714f87e960a171b119d06ee163b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.2+4"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "5c8424f8a67c3f2209646d4425f3d415fee5931d"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.27.0+4"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "79c31e7844f6ecf779705fbc12146eb190b7d845"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.4.0+3"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e45044cd873ded54b6a5bac0eb5c971392cf1927"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.2+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "b910cb81ef3fe6e78bf6acee440bda86fd6ae00c"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "ece2350174195bb31de1a63bea3a41ae1aa593b6"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "0.9.1+5"
"""

# ╔═╡ Cell order:
# ╟─ac901706-a470-47ba-8351-f9e87869ab9a
# ╟─ec7ab690-a52c-11ec-1e8a-f77727daef1a
# ╟─696e597a-45f0-44b9-b47e-a877abb87ab0
# ╟─3a5b4a4f-7955-475f-9d02-448572a3e63a
# ╟─7e7c5630-0999-401a-94ea-4e921c96d936
# ╟─2a86adbe-972a-4dd9-845d-609b187879bf
# ╟─4800127a-30be-4594-bc4e-6bb6c9c3149b
# ╟─c8262dd6-5c56-4786-be3a-9d37486a7c03
# ╟─d52565c5-e983-40d2-ab65-c76bfc3fcc01
# ╟─097d4c17-5966-4ef5-962d-c6545091e97c
# ╟─ed49e3ed-dd07-44bb-b5a5-ef86c9332859
# ╟─d07a8fee-051b-4167-9d92-d4474803e03d
# ╟─e4f95747-ab32-47df-bf4d-359aec4b81fc
# ╟─b12e6b22-0626-46d5-9608-480f454712f3
# ╟─3ef542df-44a1-43af-872e-1138c12eb17f
# ╟─51443cff-ad5e-4d21-98ac-3256198e7a11
# ╟─3179374a-be70-4025-8510-f5986a779539
# ╟─279340ea-7814-4c42-a4e6-79554262be86
# ╟─51d07f6d-f76d-4662-a71c-10422bef505f
# ╟─8abac52d-9d1f-460c-b307-4a9425696520
# ╟─b7d5379b-ce50-41c5-bc31-cb37c777ac80
# ╟─9831f016-6497-4984-bc54-749b112cd384
# ╟─5487a745-e091-42ea-9e37-4b929df74822
# ╟─444eb6b1-fc1d-4f82-ad0a-c19fc2511284
# ╟─2208fc1f-fed7-40ca-83a6-e24f6d374eae
# ╟─0c083f3d-13a0-4ed8-a892-65e9ec8f4062
# ╟─f91360f0-158a-4232-b62d-695a3dc14d70
# ╟─bc2820f8-59e9-4b3d-96b2-e9b6cf29bbf3
# ╟─31eed41d-dc07-4764-b159-0a86f594f960
# ╟─bdeb879f-dde0-4ac5-9413-d5de4e3dda76
# ╟─6b2ea6e3-8a31-4032-8f2f-4088c78fa15a
# ╟─b979ab88-6cf4-4782-b45b-e812cf87ba36
# ╟─ba00baca-f3b2-4ee4-8332-547d3590a2b8
# ╟─e139d1a2-27ba-4252-9544-81f3d91f8de9
# ╟─7583b506-778d-4000-b308-57d9192a4ead
# ╟─d189d858-e793-4571-a836-3ee3ef94b8f4
# ╟─7014b7a0-62c9-48d5-9aaa-4e84053da67e
# ╟─a33ee682-82c0-4b63-a7c8-dcf885003921
# ╟─dfa63e76-ca49-440f-91f1-bb6e1e605c72
# ╟─9a644400-a5f1-4771-9ff8-9b610376cf3e
# ╟─037558b0-ed72-470f-a65a-f9a5df04e0b2
# ╟─dab82d69-8a98-465f-bbc3-da791552adf7
# ╟─1a222185-2e57-4ed4-a70b-317e641366ab
# ╠═b829c2b9-42e7-4a35-822b-8d202b0f883f
# ╟─ce983e3e-fb57-45ad-9617-0cf0e5518778
# ╟─bb27b253-1894-4ee5-abbd-e64df9d0feb9
# ╟─23c6a842-6ed4-42d4-a56c-c821035a1453
# ╟─1f2a6398-3233-4efa-8ad5-6e608e2912d8
# ╟─dd8f5133-cfea-4947-af66-113f93a0c004
# ╟─725c4b76-0351-4ef7-b959-e17cc0f2fee2
# ╟─0c46405c-ffc0-4141-b35d-dee42692c2c1
# ╟─97a12090-5923-47c3-9487-d936ee26e294
# ╟─81ef7961-9632-4730-b0d3-1d3689d79871
# ╟─fc9463b4-63ad-4e9f-99e7-5854d039c855
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
