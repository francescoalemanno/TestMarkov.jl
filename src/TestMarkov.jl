module TestMarkov
    function build_lattice(r...)
        zeros(length.(r)...)
    end

    function randomize(p::Tuple)
        randomize(promote(p...))
    end
    function randomize(p::NTuple{N,T}) where {N,T}
        r=sign(rand()-0.05)
        (p[1]*r+randn()*0.05,randomize(Base.tail(p))...)
    end
    function randomize(p::NTuple{0})
        ()
    end
    function T(S,θ)
        perturbation=(cos(θ),sin(θ)).*0.01
        mutation=randomize(perturbation)
        S.+mutation
    end
    function __approx_fpos(vec,el)
        metric(x)=(x-el)*(x-el)
        @inbounds min=metric(vec[1])
        minloc=1
        @inbounds for i in eachindex(vec)
            nmin=metric(vec[i])
            if nmin<min
                min=nmin
                minloc=i
            end
        end
        minloc
    end
    function approx_fpos(vecs,els)
        CartesianIndex(__approx_fpos.(vecs,els))
    end


    function simulate(θ)
        X=0:0.1:10
        Y=0:0.1:10
        L=build_lattice(X,Y)
        normL=0.0
        iS=(1.0,2.5)
        S=iS
        for i in 1:100000
            P=approx_fpos((X,Y),S)
            L[P]+=1
            normL+=1
            S=T(S,θ)
            if i%1000 == 0
                S=iS
            end
        end
        X,Y,L
    end
    export simulate
end # module
