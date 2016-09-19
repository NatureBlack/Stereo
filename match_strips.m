function disparity = match_strips(strip_left, strip_right, b)
    % For each non-overlapping patch/block of width b in the left strip,
    %   find the best matching position (along X-axis) in the right strip.
    % Return a vector of disparities (left X-position - right X-position).
    % Note: Only consider whole blocks that fit within image bounds.
    num_blocks = floor(size(strip_left, 2) / b);
    disparity = zeros(1, num_blocks);
    for blocks = 1 : num_blocks
        x_left = (blocks - 1) * b + 1;
        patch_left = strip_left( : , x_left : x_left + b - 1);
        x_right = find_best_match(patch_left, strip_right);
        disparity(blocks) = x_left - x_right;
    end
end

% Find best match for a patch in a given strip (SSD)
% Note: You may use this or roll your own
function best_x = find_best_match(patch, strip)
    min_diff = Inf;
    best_x = 0; % column index (x value) of topleft corner; haven't found it yet
    for x = 1:(size(strip, 2) - size(patch, 2))
        other_patch = strip(:, x:(x + size(patch, 2) - 1));
        diff = sum(sum((patch - other_patch) .^ 2));
        if diff < min_diff
            min_diff = diff;
            best_x = x;
        end
    end
end
