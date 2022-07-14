const std = @import("std");
const print = @import("std").debug.print;

const Point = struct {
    x: i32,
    y: i32,

    fn add(self: Point, other: Point) Point {
        return Point{
            .x = self.x + other.x,
            .y = self.y + other.y,
        };
    }
};

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Hello, {s}!\n", .{"world"});

    print("Hello, {s}!\n", .{"world"});

    const x = 1 + 1;

    print("{}\n", .{x});
    print("{}{}\n", .{ true, false });

    const p = Point{ .x = 10, .y = 32 };
    print("point is {}\n", .{p});
    print("point is {}\n", .{p.add(Point{ .x = 11, .y = 33 })});

    const allocator = std.heap.page_allocator;

    const memory = try allocator.alloc(u8, 100);
    defer allocator.free(memory);

    print("memory.len={}\n", .{memory.len});
    print("@TypeOf(memory)={}\n", .{@TypeOf(memory)});
}

test "add" {
    const p1 = Point{ .x = 10, .y = 32 };
    const p2 = Point{ .x = 12, .y = 14 };

    const px = p1.add(p2);

    try std.testing.expectEqual(px, Point{.x=22, .y=46 });
}

const eql = std.mem.eql;
const ArrayList = std.ArrayList;
const test_allocator = std.testing.allocator;

test "arraylist" {
    var list = ArrayList(u8).init(test_allocator);
    defer list.deinit();
    try list.append('H');
    try list.append('e');
    try list.append('l');
    try list.append('l');
    try list.append('o');
    try list.appendSlice(" World!");

    try std.testing.expect(eql(u8, list.items, "Hello World!"));
}
