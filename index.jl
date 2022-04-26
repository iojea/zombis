### A Pluto.jl notebook ###
# v0.18.1

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
	using HypertextLiteral: @htl
	using PlutoUI
	using Plots
	theme(:wong)
end

# ╔═╡ ec7ab690-a52c-11ec-1e8a-f77727daef1a
@htl("""<h1 class="title">Cómo sobrevivir a una invasión zombi: ¡usando matemática!</h1>

	<style> 
		.title {
			background: #EEEEEE;
			border-radius: 12px;
			text-align: center;
			padding: 0px 10px 0px 10px;
			color: #4080AA;
		}
	</style>""")

# ╔═╡ 696e597a-45f0-44b9-b47e-a877abb87ab0
@htl("""<h2 class="title">Primera Parte</h2>""")

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
@htl("""<h3 class="title">Crecimiento con natalidad y mortalidad</h3>""")

# ╔═╡ 097d4c17-5966-4ef5-962d-c6545091e97c
md"""
Suponemos que la  población tiene la siguiente dinámica: en un instante de tiempo, la cantidad de zombis $z_{n+1}$ es igual a la que había en el instante anterior, $z_n$, agregando los que se transforman en zombis $+N z_n$, y restando las muertes $-M z_n$ (observar que el contagio y la mortalidad son proporcionales a la cantidad de zombis). Esto se puede escribir como


$\begin{align*}
	 z_{n+1}&:=z_n +N z_n - M z_n \\
	 &=z_n+(N-M)z_n\\
	 &=(1+N-M)z_n\\
	 &:=\beta z_n
\end{align*}$

donde $z_n$ representa la cantidad de zombis en el instante $n$, siendo $n$ por ejemplo, años."""

# ╔═╡ ed49e3ed-dd07-44bb-b5a5-ef86c9332859
md"""

1.   Si inicialmente hay ${\color{blue}{Z}}$ zombis y sabemos que:

  *   La tasa de contagio (*natalidad*) es del $n\%$ anual, es decir ${\color{blue}{N=n/100}}$
  *   La tasa de mortalidad es de $m\%$ anual, es decir: ${\color{blue}{M=m/100}}$.

    La pregunta es: ¿Cuántos zombis habrá dentro de $15$ años?

    Moviendo los siguientes deslizadores se puede observar el comportamiento de la población de zombis dependiendo de los parámetros:"""

# ╔═╡ d07a8fee-051b-4167-9d92-d4474803e03d
md"""
 Z = $(@bind Z Slider(1000:10:10000,default=1000,show_value=true)) 

 n = $(@bind n Slider(0:0.01:1,default=0.5,show_value=true)) 

 m = $(@bind m Slider(0:0.01:1,default=0.3,show_value=true))
"""

# ╔═╡ e4f95747-ab32-47df-bf4d-359aec4b81fc
begin 
	tiempo = 15
	zombis = zeros(15)
	zombis[1] = (1+n-m)*Z
	for i in 2:15
		zombis[i] = (1+n-m)*zombis[i-1]
	end
	scatter(zombis,legend=:top,label="zombis")
end

# ╔═╡ b12e6b22-0626-46d5-9608-480f454712f3
md"""¿Qué ocurre si hay más contagios que muertes? 

 ¿Qué ocurre si hay más muertes que contagios? 

¿Qué ocurre si las muertes y los contagios se equiparan?"""

# ╔═╡ 97a4a916-096b-4361-8d1b-0424a63d4edd
md"""Recordemos que habíamos deducido que la cantidad de zombis se puede escribir como $z_n = \beta^n z_0$.

En nuestro caso $\beta = (1+n-m)$, para conocer la población luego de $15$ años podríamos hacer directamente este cálculo:

$z_{15} = (1+0.2-0.1)^{14}\cdot 1000$

Volvemos a hacer el gráfico anterior y agregamos el valor de $z_{15}$, destacado:"""

# ╔═╡ c1f2e4dd-c4ca-43fa-9fe8-8f2a8436893e
begin
	β   = (1+n-m)
	z15 = β^15*Z
	scatter(zombis,legend=:top,label="zombis")
	scatter!([15],[z15],label="z15",marker=:star5,markersize=8)
end

# ╔═╡ 6bbd67c1-6b98-468d-8ff4-022cc5bc48e0
@htl("""<p class="separator"></p>

	<style> 
		.separator {
			height: 5px;
			background-color:darkslategray;
		}
	</style>""")

# ╔═╡ 3ef542df-44a1-43af-872e-1138c12eb17f
@htl("""<h2 class="title">Competencia entre especies</h2>""")

# ╔═╡ 51443cff-ad5e-4d21-98ac-3256198e7a11
md"""2.   Pero la cantidad de zombis y la cantidad de humanos dependen una de la otra. Empecemos suponiendo simplemente que la cantidad de zombis aumenta proporcionalmente a la cantidad de humanos. Entonces: 
$$\left\lbrace\begin{array}{rcl}h_{k+1} & = & h_k-\alpha h_k \\ z_{k+1} & = & z_k+\alpha h_k \end{array}\right.$$
¿Cómo es la evolución de las poblaciones si, por ejemplo, $h_0=1000$, $z_0=1$, $\alpha = 0.05$?"""



# ╔═╡ 3179374a-be70-4025-8510-f5986a779539
md"""
 z₀ = $(@bind z₀ Slider(1:10:100,default=1,show_value=true)) 

 h₀ = $(@bind h₀ Slider(1000:10:10000,default=1000,show_value=true)) 

 α = $(@bind α Slider(0:0.01:1,default=0.05,show_value=true)) 
"""

# ╔═╡ d6f488cb-79f5-4b97-a0ae-2065822d7f67
md"""$(@bind gtot CheckBox()) Población total"""



# ╔═╡ b7d5379b-ce50-41c5-bc31-cb37c777ac80
begin
	h = zeros(16)
	z = zeros(16)
	h[1] = h₀
	z[1] = z₀
	for i in 2:16
		h[i] = h[i-1] - α*h[i-1]
		z[i] = z[i-1] + α*h[i-1]
	end
	if gtot
		scatter(0:15,z,legend=:top,label="zombis")
		scatter!(0:15,h,label="humanos")
		scatter!(0:15,z+h,label="total")
	else
		scatter(0:15,z,legend=:top,label="zombis")
		scatter!(0:15,h,label="humanos")
	end
end

# ╔═╡ 9831f016-6497-4984-bc54-749b112cd384
md"""3.   También podemos pensar que la cantidad de humanos decrece de manera proporcional a la cantidad de zombis, mientras que los zombis aumentan de manera proporcional a la cantidad de humanos:
$$\left\lbrace\begin{array}{rcl}h_{k+1} & = & h_k-\alpha z_k \\ z_{k+1} & = & z_k+\beta h_k \end{array}\right.$$
¿Cómo varía la cantidad de humanos si hay muchos zombis? ¿Y si hay pocos?<br> ¿Qué pasa con los zombis? ¿Y después de un largo tiempo, qué pasa?

Probamos con $h_0=1000$, $z_0=10$, $\alpha=0.01$ y $\beta=0.05$.

¿Qué ocurre con la cantidad total de individuos (humanos + zombis)?

¿Y si se invierten los valores de $\alpha$ y $\beta$?"""

# ╔═╡ 5487a745-e091-42ea-9e37-4b929df74822
md"""
 z₀ = $(@bind z2₀ Slider(1:3:100,default=10,show_value=true)) 

 h₀ = $(@bind h2₀ Slider(1000:10:10000,default=1000,show_value=true)) 

 α = $(@bind α2 Slider(0:0.01:1,default=0.05,show_value=true)) 
 
 β = $(@bind β2 Slider(0:0.01:1,default=0.05,show_value=true)) 
"""

# ╔═╡ 444eb6b1-fc1d-4f82-ad0a-c19fc2511284
md"""$(@bind gtot2 CheckBox()) Población total"""

# ╔═╡ 2208fc1f-fed7-40ca-83a6-e24f6d374eae
begin
	h2 = zeros(16)
	z2 = zeros(16)
	h2[1] = h2₀
	z2[1] = z2₀
	for i in 2:16
		h2[i] = h2[i-1] - α2*z2[i-1]
		z2[i] = z2[i-1] + β2*h2[i-1]
	end
	if gtot2
		scatter(0:15,z2,legend=:top,label="zombis")
		scatter!(0:15,h2,label="humanos")
		scatter!(0:15,z2+h2,label="total")
	else
		scatter(0:15,z2,legend=:top,label="zombis")
		scatter!(0:15,h2,label="humanos")
	end
end

# ╔═╡ 6b2ea6e3-8a31-4032-8f2f-4088c78fa15a
md""" 
5.  Veamos un modelo más complejo. Consideremos los siguiente:

  *   Los humanos nacemos proporcionalmente a nuestra población (a tasa $N$),
  *   Para que un humano se convierta en zombi, se tiene que encontrar un humano con un zombi, tiene que haber interacción y hay una tasa de efectividad con la que los zombis logran contagiar a los humanos ($a$),
  *   Los humanos morimos por causas ajenas a los zombis proporcionalmente a nuestra población (a tasa $M$),
  *   Los zombis no se reproducen ni mueren por causas naturales.
  *   Los zombis pueden morir cuando hay encuentro con humanos porque los humanos los matamos con una cierta tasa de efectividad ($b$).

    Las ecuaciones quedan:
  
$\left\lbrace\begin{array}{rcl}h_{k+1} & = & h_k+N h_k-M h_k - a h_k z_k \\ 
z_{k+1} & = & z_k+a h_k z_k -b h_k z_k \\
\end{array}\right.$"""



# ╔═╡ b979ab88-6cf4-4782-b45b-e812cf87ba36
md"""Graficamos la situación asumiendo que en un comienzo hay 1000 humanos y 5 zombis. Como referencia: la tasa de natalidad anual de la Argentina es de 17 por mil (0.017), mientras que la tasa de mortalidad es de 8 por mil. 

¿Es posible encontrar valores de los parámetros que conduzcan a una convivencia de humanos y zombis? ¿O siempre hay una de las dos *especies* que, a la larga, se extingue? """

# ╔═╡ ba00baca-f3b2-4ee4-8332-547d3590a2b8
md"""
 N = $(@bind N Slider(0:0.001:0.02,default=0.001,show_value=true)) 

 M = $(@bind M Slider(0:0.001:0.02,default=0.001,show_value=true)) 

 a = $(@bind a Slider(0:0.0001:0.002,default=0.001,show_value=true)) 
 
 b = $(@bind b Slider(0:0.0001:0.002,default=0.001,show_value=true)) 

tiempo = $(@bind pasos Slider(10:500,default=20,show_value=true)) 
"""

# ╔═╡ e139d1a2-27ba-4252-9544-81f3d91f8de9
md"""$(@bind gtot3 CheckBox()) Población total"""

# ╔═╡ 7583b506-778d-4000-b308-57d9192a4ead
begin
	hInter    = zeros(pasos+1)
	zInter    = zeros(pasos+1)
	hInter[1] = 20
	zInter[1] = 5
	for i in 2:pasos+1
		hInter[i] = hInter[i-1] + (N-M)*hInter[i-1] - a*hInter[i-1]*zInter[i-1]
		zInter[i] = zInter[i-1] + (a-b)*hInter[i-1]*zInter[i-1]
	end
	if gtot3
		scatter(0:pasos,zInter,legend=:top,label="zombis")
		scatter!(0:pasos,hInter,label="humanos")
		scatter!(0:pasos,zInter+hInter,label="total")
	else
		scatter(0:pasos,zInter,legend=:top,label="zombis")
		scatter!(0:pasos,hInter,label="humanos")
	end
end

# ╔═╡ 7014b7a0-62c9-48d5-9aaa-4e84053da67e
md"""
6. Se puede observar una dinámica interesante si contemplamos la posibilidad de que los zombis mueran por "causas naturales". En ese caso, las ecuaciones quedan:

$\left\lbrace\begin{array}{rcl}h_{k+1} & = & h_k+(N-M) h_k - a h_k z_k \\ 
z_{k+1} & = & c z_k+(a-b) h_k z_k \\
\end{array}\right.$

Donde $c$ es la proporción de zombis que sobrevivirían con independencia de los encuentros con humanos.  Para simplificar el estudio de este modelo asumiremos que $N=0.017$, $M=0.008$ y que inicialmente hay 20 humanos y 5 zombis. 

Nuevamente: ¿Existe alguna forma de que humanos y zombis convivan? ¿O siempre alguno de los dos deberá extinguirse?"""

# ╔═╡ a33ee682-82c0-4b63-a7c8-dcf885003921
md"""
 a = $(@bind a2 Slider(0:0.0001:0.002,default=0.001,show_value=true)) 
 
 b = $(@bind b2 Slider(0:0.0001:0.002,default=0.001,show_value=true)) 

 c = $(@bind c2 Slider(0.5:0.01:1,default=0.1,show_value=true))

tiempo = $(@bind pasos2 Slider(10:1500,default=20,show_value=true)) 
"""

# ╔═╡ dfa63e76-ca49-440f-91f1-bb6e1e605c72
md"""$(@bind gtot4 CheckBox()) Población total"""

# ╔═╡ 9a644400-a5f1-4771-9ff8-9b610376cf3e
begin
	N2         = 0.017
	M2         = 0.008
	hInter2    = zeros(pasos2+1)
	zInter2    = zeros(pasos2+1)
	hInter2[1] = 19
	zInter2[1] = 5
	for i in 2:pasos2+1
		hInter2[i] = (1+N2-M2)*hInter2[i-1] - a2*hInter2[i-1]*zInter2[i-1]
		zInter2[i] = c2*zInter2[i-1] + (a2-b2)*hInter2[i-1]*zInter2[i-1]
	end
	if gtot4
		plot(0:pasos2,zInter2,legend=:top,label="zombis")
		plot!(0:pasos2,hInter2,label="humanos")
		plot!(0:pasos2,hInter2+zInter2,label="total")
	else
		plot(0:pasos2,zInter2,legend=:top,label="zombis")
		plot!(0:pasos2,hInter2,label="humanos")
	end
end

# ╔═╡ 037558b0-ed72-470f-a65a-f9a5df04e0b2
@htl("""<h2 class="title">Modelos epidémicos</h2>""")

# ╔═╡ dab82d69-8a98-465f-bbc3-da791552adf7
md"""Para terminar, consideremos el modelo para enfermedades infecciosas $SI$:

$\left\lbrace\begin{array}{rcl}
S_{k+1} & = & S_k+ N(S_k+I_k)-m_1 S_k - a S_k I_k \\ 
I_{k+1} & = & I_k - m_2 I_k + a S_k I_k \\
\end{array}\right.$
"""


# ╔═╡ 1a222185-2e57-4ed4-a70b-317e641366ab
md"""Nuevamente, fijamos los valores $N=0.017$, $m_1=0.008$ y asumimos que la población inicial está formada por $1000$ suceptibles y $5$ infectados.

Agregamos (de manera opciona) una tercer curva que muestra la población total (S+I)."""

# ╔═╡ b829c2b9-42e7-4a35-822b-8d202b0f883f
md"""
 m₂ = $(@bind m2 Slider(0:0.01:0.2,default=0.001,show_value=true)) 
 
 a = $(@bind η Slider(0:0.0001:0.001,default=0.001,show_value=true)) 

tiempo = $(@bind steps Slider(10:1500,default=20,show_value=true)) 
"""

# ╔═╡ ce983e3e-fb57-45ad-9617-0cf0e5518778
md"""$(@bind total CheckBox()) Población Total"""

# ╔═╡ bb27b253-1894-4ee5-abbd-e64df9d0feb9
begin
	Ntot = 0.017
	Mtot = 0.008
	S    = zeros(steps+1)
	I    = zeros(steps+1)
	S[1] = 1000
	I[1] = 5
	for i in 2:steps+1
		S[i] = S[i-1] + Ntot*(S[i-1]+I[i-1]) - Mtot*S[i-1]-η*S[i-1]*I[i-1]
		I[i] = I[i-1] - m2*I[i-1] + a*S[i-1]*I[i-1]
	end

	if total
		plot(0:steps,S,legend=:top,label="S")
		plot!(0:steps,I,label="I")
		plot!(0:steps,S+I,label="Total")
	else
		plot(0:steps,S,legend=:top,label="S")
		plot!(0:steps,I,label="I")
	end
	
end

# ╔═╡ 23c6a842-6ed4-42d4-a56c-c821035a1453
md"""¿Qué se observa? ¿Cómo es el comportamiento de las curvas al cambiar los parámetros? 

Probar con $m_2=0.15$ y $a=0.0005$. ¿Qué se ve a largo plazo? ¿Cómo debe interpretarse el gráfico?"""



# ╔═╡ 725c4b76-0351-4ef7-b959-e17cc0f2fee2
md"""Por último, consideremos el modelo que agrega la vacunación: 

$\left\lbrace\begin{array}{rcl}
S_{k+1} & = & S_k+ N(S_k+I_k)-m_1 S_k - a S_k I_k +vI_n \\ 
I_{k+1} & = & I_k - m_2 I_k + a S_k I_k -vI_n\\
\end{array}\right.$"""

# ╔═╡ 0c46405c-ffc0-4141-b35d-dee42692c2c1
md"""
 a = $(@bind ξ Slider(0:0.0001:0.001,default=0.001,show_value=true))

 v = $(@bind v Slider(0:0.001:1,default=0.001,show_value=true))

tiempo = $(@bind steps2 Slider(10:1500,default=20,show_value=true)) 
"""

# ╔═╡ 97a12090-5923-47c3-9487-d936ee26e294
md"""$(@bind totv CheckBox()) Población Total"""

# ╔═╡ 81ef7961-9632-4730-b0d3-1d3689d79871
begin
	Ntotv = 0.017
	Mtotv = 0.008
	Miv   = 0.001
	Sv     = zeros(steps2+1)
	Iv     = zeros(steps2+1)
	Sv[1]  = 1000
	Iv[1]  = 5
	for i in 2:steps2+1
		Sv[i] = Sv[i-1] + Ntotv*(Sv[i-1]+Iv[i-1]) - Mtotv*Sv[i-1]-ξ*Sv[i-1]*Iv[i-1]
		Iv[i] = Iv[i-1] - Miv*Iv[i-1] + ξ*Sv[i-1]*Iv[i-1]-v*Iv[i-1]
	end

	if totv
		plot(0:steps2,Sv,legend=:top,label="S")
		plot!(0:steps2,Iv,label="I")
		plot!(0:steps2,Sv+Iv,label="Total")
	else
		plot(0:steps2,Sv,legend=:top,label="S")
		plot!(0:steps2,Iv,label="I")
	end
	
end

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
# ╟─97a4a916-096b-4361-8d1b-0424a63d4edd
# ╟─c1f2e4dd-c4ca-43fa-9fe8-8f2a8436893e
# ╟─6bbd67c1-6b98-468d-8ff4-022cc5bc48e0
# ╟─3ef542df-44a1-43af-872e-1138c12eb17f
# ╟─51443cff-ad5e-4d21-98ac-3256198e7a11
# ╟─3179374a-be70-4025-8510-f5986a779539
# ╟─d6f488cb-79f5-4b97-a0ae-2065822d7f67
# ╟─b7d5379b-ce50-41c5-bc31-cb37c777ac80
# ╟─9831f016-6497-4984-bc54-749b112cd384
# ╟─5487a745-e091-42ea-9e37-4b929df74822
# ╟─444eb6b1-fc1d-4f82-ad0a-c19fc2511284
# ╟─2208fc1f-fed7-40ca-83a6-e24f6d374eae
# ╟─6b2ea6e3-8a31-4032-8f2f-4088c78fa15a
# ╟─b979ab88-6cf4-4782-b45b-e812cf87ba36
# ╟─ba00baca-f3b2-4ee4-8332-547d3590a2b8
# ╟─e139d1a2-27ba-4252-9544-81f3d91f8de9
# ╟─7583b506-778d-4000-b308-57d9192a4ead
# ╟─7014b7a0-62c9-48d5-9aaa-4e84053da67e
# ╟─a33ee682-82c0-4b63-a7c8-dcf885003921
# ╟─dfa63e76-ca49-440f-91f1-bb6e1e605c72
# ╟─9a644400-a5f1-4771-9ff8-9b610376cf3e
# ╟─037558b0-ed72-470f-a65a-f9a5df04e0b2
# ╟─dab82d69-8a98-465f-bbc3-da791552adf7
# ╟─1a222185-2e57-4ed4-a70b-317e641366ab
# ╟─b829c2b9-42e7-4a35-822b-8d202b0f883f
# ╟─ce983e3e-fb57-45ad-9617-0cf0e5518778
# ╟─bb27b253-1894-4ee5-abbd-e64df9d0feb9
# ╟─23c6a842-6ed4-42d4-a56c-c821035a1453
# ╟─725c4b76-0351-4ef7-b959-e17cc0f2fee2
# ╟─0c46405c-ffc0-4141-b35d-dee42692c2c1
# ╟─97a12090-5923-47c3-9487-d936ee26e294
# ╟─81ef7961-9632-4730-b0d3-1d3689d79871
