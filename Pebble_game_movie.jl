using Plots
using LinearAlgebra 
Var = [i for i in 1:36]
Mat_ = reshape(Var, (6, 6))
Mat = permutedims(Mat_)
Neighbor = zeros(36, 4)
for i in 1:6
    for j in 1:6
        if i < 6
            N1 = Mat[i + 1, j]
        else
            N1 = Mat[i, j]
        end
        Neighbor[6*(i - 1) + j, 1] = N1
        if i > 1
            N2 = Mat[i - 1, j]
        else
            N2 = Mat[i, j]
        end
        Neighbor[6*(i - 1) + j, 2] = N2
        if j < 6
            N3 = Mat[i, j + 1]
        else
            N3 = Mat[i, j]
        end
        Neighbor[6*(i - 1) + j, 3] = N3
        if j > 1
            N4 = Mat[i, j - 1]
        else
            N4 = Mat[i, j]
        end
        Neighbor[6*(i - 1) + j, 4] = N4
    end
end
Neighbour = Int.(floor.(Neighbor))
Position = zeros(36)
Position[1] = 1
animat = Animation()
Transfer = zeros(36, 36)
for k in 1:36
    for w in 1:4 
        Transfer[Neighbour[k, w], k] += 0.25
    end
end
for iter in 1:50
    Matu = reshape(Position, 6, 6)
    heatmap(Matu, clims = (0, 1), c=:viridis, size = (600, 600), xlims = (1, 6), ylims = (1, 6), title = "Residing Probability for t = $iter")
    Position = Transfer*Position
    frame(animat)
end
mp4(animat, "Heatmap1.mp4", fps = 0.5)
