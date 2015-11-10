require 'date'


Nodo = Struct.new(:dato, :nodoSiguiente) 

Lista = Struct.new(:cabeza) do
	def vacia
		vacia = cabeza == nil ? true : false 
	end

	def ultimo
		if(vacia)
			return nil
		end
		nodoActual = cabeza
		while(nodoActual.nodoSiguiente != nil)
			nodoActual = nodoActual.nodoSiguiente
		end
		return nodoActual
	end

	def insertarFinal(nodo)
		if(vacia)
			self.cabeza = nodo
		else
			ultimo.nodoSiguiente = nodo 
		end 
	end
	
	def insertarInicio(nodo)
		if(vacia)
			self.cabeza = nodo 
		else
			aux = cabeza
			self.cabeza = nodo 
			self.cabeza.nodoSiguiente = aux
		end	
	end
	
	def extraerUltimo
		if(vacia)
			return nil
		end
		nodoActual = cabeza
		if(ultimo == cabeza)
			aux = cabeza
			cabeza = nil
			return aux
		end 
		while(nodoActual.nodoSiguiente.nodoSiguiente != nil)
			nodoActual = nodoActual.nodoSiguiente
		end	
		aux = nodoActual.nodoSiguiente
		nodoActual.nodoSiguiente = nil
		return aux 
	end
	
	def extraerCabeza
		if(vacia)
			return nil
		end
		aux = cabeza
		self.cabeza = self.cabeza.nodoSiguiente
		return aux	
	end
end




class Referencias
	attr_reader :autor,:titulo, :serie, :editorial, :numEdicion, :fecha, :codISBN, :fechaDate
  	def initialize(autor, titulo, editorial, numEdicion, fecha, codISBN, serie = 'null')
		@autor, @titulo, @serie, @editorial, @numEdicion, @codISBN, @fecha = autor, titulo, serie, editorial, numEdicion, codISBN, fecha 
		afecha = fecha.split(/\//)  
		@fechaDate = Date.new(afecha[2].to_i, afecha[1].to_i, afecha[0].to_i)
  	end
	
	def autorPrint()
		autores = ""
		size = @autor.length - 1 
		for i in 0..size
			if i != size
				autores += "#{@autor[i]}, "
			else
				autores += "#{@autor[i]}."
			end
		end
		return autores
	end
	
	def fechaFormateada()
		fechaFormateada = "#{@fechaDate.strftime("%B")} #{@fechaDate.mday}, #{@fechaDate.year}"
	end
	
	def codISBNprint()
		listadoISBN = ""
		size = @codISBN.length - 1 
		for i in 0..size
			if i != size
				listadoISBN += "#{@codISBN[i]}\n"
			else
				listadoISBN += "#{@codISBN[i]}"
			end
		end
		return listadoISBN
	end

	def salidaFormateada()
		if @serie != "null"
			salida = "#{autorPrint()}\n#{@titulo}\n(#{@serie})\n#{@editorial}; #{@numEdicion} edition (#{fechaFormateada()})\n#{codISBNprint()}"
		else
			salida = "#{autorPrint()}\n#{@titulo}\n#{@editorial}; #{@numEdicion} edition (#{fechaFormateada()})\n#{codISBNprint()}"
			
		end
	end
end
     
